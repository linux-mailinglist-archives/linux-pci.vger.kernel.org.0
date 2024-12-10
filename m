Return-Path: <linux-pci+bounces-18039-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B153A9EB850
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 18:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF3CE1886F88
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 17:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE6923ED70;
	Tue, 10 Dec 2024 17:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3OlXSDR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE5623ED64;
	Tue, 10 Dec 2024 17:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733851930; cv=none; b=ndQiYfVnnhJZGzSyM6ZfbZZ0XblRSDLR0z7P4tyfTTFxypmemYQOoqd2bXkR+ovbo3PrtSPe9Neqpyc5ndxYspl94NAwya34wUNGZoaRI6fosknfB64s6xZlvJmTu/TmPhGBRGlQZ3ANLts/0vcpNs3pHvJHo2uWE0s7iaTvQus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733851930; c=relaxed/simple;
	bh=IxO2jZVD7vsyOj0R6kZ+Q4fChpCEVzfOmGWNeuAqZU0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=V73aZg2x+KROnQWkF0Lom/NGDEfdn7WBCW5sBRwoilnHox6yD6efOYKg2GDWQbpzXscecQGNOcxT2i+YoMQ33+qPV2+2PokGdX8qfWJvDy9ezTGn6PIsi06kJdGZTkFgvBjiWNI4fokrZj/+NQ6D7KeK/VfdqiSlFRE1zS9SwBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t3OlXSDR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3E42C4CED6;
	Tue, 10 Dec 2024 17:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733851930;
	bh=IxO2jZVD7vsyOj0R6kZ+Q4fChpCEVzfOmGWNeuAqZU0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=t3OlXSDRD2a/bgR5s7zm+vNw1rGNC/BISmDSJjCWf4bs/Y+TNQDnMA6iqkulof9xn
	 H/bWksCsWwz6x8hTF4NKS5WohswdbbwbYsqoTK2ud2J6ivC74OyWwKupVQ+aJNAZ5q
	 dwENrC8DQS3YCT+llKVL6hHFzOngMso7aXHPTjcbJAJZKys5n3cpjeI6+rtnXWVl+E
	 P16KlrudVnVpRprYCaYU3WuycyYS4XryHRmAilipCk92y/QENjunkEki/FaesgFgxN
	 1Yjgv4HuK91TTUD07aHXt0qZA75lZrCW31QSEJ9ReVziEKbCaKuFVYp6swwdnakM+l
	 /98oUswqsptoQ==
Date: Tue, 10 Dec 2024 11:32:08 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Chen Wang <unicornxw@gmail.com>
Cc: kw@linux.com, u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu,
	arnd@arndb.de, bhelgaas@google.com, unicorn_wang@outlook.com,
	conor+dt@kernel.org, guoren@kernel.org, inochiama@outlook.com,
	krzk+dt@kernel.org, lee@kernel.org, lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org, palmer@dabbelt.com,
	paul.walmsley@sifive.com, pbrobinson@gmail.com, robh@kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com, xiaoguang.xing@sophgo.com,
	fengchun.li@sophgo.com
Subject: Re: [PATCH v2 3/5] dt-bindings: mfd: syscon: Add sg2042 pcie ctrl
 compatible
Message-ID: <20241210173208.GA3248062@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29ceb01afb1838755b4b64ae891f51a5b1bb7716.1733726572.git.unicorn_wang@outlook.com>

On Mon, Dec 09, 2024 at 03:20:14PM +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> Document SOPHGO SG2042 compatible for PCIe control registers.
> These registers are shared by pcie controller nodes.

s/pcie/PCIe/ to be consistent (also in subject and other patches).

