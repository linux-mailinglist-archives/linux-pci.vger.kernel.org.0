Return-Path: <linux-pci+bounces-36182-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CE3B58225
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 18:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 924403AFFCB
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 16:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F46523908B;
	Mon, 15 Sep 2025 16:32:30 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A0327A103
	for <linux-pci@vger.kernel.org>; Mon, 15 Sep 2025 16:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757953950; cv=none; b=uxvqHxBEca/CwiG8OQ0xbWcr8JpKErDv8pYi1Vj0AJm4Zy7habwGXjYIIkbrrL/llo6TddgL+ZnjJXt/fg/P48K0PPFAmVvoMhV7Adz5+yXmwwXQ6Eq5Bp6WEq0uRpC9pC54EX3AE2hpOvjTsCkdXq6erFMcsM69Fh85TDOhJxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757953950; c=relaxed/simple;
	bh=aZusdISN2SAjdOUcYfVEgUykopuyr/RYuQBZ6x0rQyA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZQd3t4tJjlC1hs6Kl1Y2zXOH5tjrFrdEK9470qAsBM+DokF70G/w/e7ui+VwM7kYDVjlnVKvvES4g1TuEuwCKKeLEcCGEv2hZJdn1+uWLON7MYa6fyqc2G5V5ebynpp+fmwjgT1RRAn1fXXZnpsE6edzRPUm27DOrTYYIAwY1uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cQVrw6WDyz6GD92;
	Tue, 16 Sep 2025 00:30:56 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 8CE6C140137;
	Tue, 16 Sep 2025 00:32:24 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 15 Sep
 2025 18:32:23 +0200
Date: Mon, 15 Sep 2025 17:32:22 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-pci@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<gregkh@linuxfoundation.org>, <bhelgaas@google.com>, <lukas@wunner.de>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Alexey Kardashevskiy
	<aik@amd.com>, Xu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [PATCH resend v6 02/10] PCI/IDE: Enumerate Selective Stream IDE
 capabilities
Message-ID: <20250915173222.000028f4@huawei.com>
In-Reply-To: <20250911235647.3248419-3-dan.j.williams@intel.com>
References: <20250911235647.3248419-1-dan.j.williams@intel.com>
	<20250911235647.3248419-3-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 11 Sep 2025 16:56:39 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Link encryption is a new PCIe feature enumerated by "PCIe r7.0 section
> 7.9.26 IDE Extended Capability".
> 
> It is both a standalone port + endpoint capability, and a building block
> for the security protocol defined by "PCIe r7.0 section 11 TEE Device
> Interface Security Protocol (TDISP)". That protocol coordinates device
> security setup between a platform TSM (TEE Security Manager) and a
> device DSM (Device Security Manager). While the platform TSM can
> allocate resources like Stream ID and manage keys, it still requires
> system software to manage the IDE capability register block.
> 
> Add register definitions and basic enumeration in preparation for
> Selective IDE Stream establishment. A follow on change selects the new
> CONFIG_PCI_IDE symbol. Note that while the IDE specification defines
> both a point-to-point "Link Stream" and a Root Port to endpoint
> "Selective Stream", only "Selective Stream" is considered for Linux as
> that is the predominant mode expected by Trusted Execution Environment
> Security Managers (TSMs), and it is the security model that limits the
> number of PCI components within the TCB in a PCIe topology with
> switches.
> 
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Oops. I missed v6 and replied to 5.   Anyhow, comments stand so
please take a look back at that. As does
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

