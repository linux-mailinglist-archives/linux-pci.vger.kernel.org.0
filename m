Return-Path: <linux-pci+bounces-14876-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E749A431A
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 18:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B816EB24011
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 16:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2C613BADF;
	Fri, 18 Oct 2024 16:00:09 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF47202655;
	Fri, 18 Oct 2024 16:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729267209; cv=none; b=Sra37mqqdFbJr0mNNTEVbxHUzp59fGIn1bxPqwjpqV3rDvso7ERrofN8mT/F7MfNNh6WZ1pJxmasMvIMKA5fHKjaYa4UseWEiL9mQamlqPeyzzcXO4NcJhOeFTHSGuZhH1c8/VTbOfOk0Ix2UTyvWP0hBU4UFA+YRWYF6Jpn2jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729267209; c=relaxed/simple;
	bh=VoO68KJ8tGrGVPKMEzuQ087VzqhbpAOrJ+LGyTFrwYg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QXwkoXunD2+Ej5eOvp33geyDk739bl/8XE6GTw2j8VW8N/jV83jsirKnKOxuGKbxJg2kfns18Mwcr6lZ9Rufn8OKx5sY/K5eM1PW5d4tXFYs88XJPWssJzuGaNiceNg/twIUT8qf/afWzLtXJVZ0cWlLmcnojqDNdwHVgQYisfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XVTsj1VP3z67fBs;
	Fri, 18 Oct 2024 23:59:21 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 93C1414038F;
	Sat, 19 Oct 2024 00:00:04 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 18 Oct
 2024 18:00:04 +0200
Date: Fri, 18 Oct 2024 17:00:02 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] PCI: Move struct pci_bus_resource into bus.c
Message-ID: <20241018170002.00000391@Huawei.com>
In-Reply-To: <20241017141111.44612-2-ilpo.jarvinen@linux.intel.com>
References: <20241017141111.44612-1-ilpo.jarvinen@linux.intel.com>
	<20241017141111.44612-2-ilpo.jarvinen@linux.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 17 Oct 2024 17:11:09 +0300
Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> The struct pci_bus_resource is only used in bus.c so move it there.
>=20
> Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

