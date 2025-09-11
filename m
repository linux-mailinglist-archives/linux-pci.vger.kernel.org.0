Return-Path: <linux-pci+bounces-35919-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C41C5B53931
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 18:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 005CEAC133F
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 16:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F9736C094;
	Thu, 11 Sep 2025 16:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="pvJXc7OO"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay-us1.mymailcheap.com (relay-us1.mymailcheap.com [51.81.35.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9888B362060;
	Thu, 11 Sep 2025 16:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.81.35.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757607821; cv=none; b=ns41CFrT4eFq52AIn2thxabrDEQ5NpnDr+5obbJX2zMOxdd0fpDfAbkp4WwcGLVRWevkbN+K2EoXjZRGduaAAE+oW/GTBAW5xu6Ga3M5sjsOB4SMlHliSwtsdm+Mf0OY4AsFhRUoRIIN1khi4TYOasI4ABSTglOEcVlEKeISe2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757607821; c=relaxed/simple;
	bh=e2daLt1V5mwDLfvAGnCZnTwhKH5st86SEoa+sdQ3cwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=F3Y45wF/rp1lbQbQqFYXmbjwvGVCKukLm+XU9h0T4NBq6dayNXOIy5aCQ7rpOv0fRfJY/SDD1VJbAb2zwKNrUzy6qq4HD/d2igFqEpF7YvCElaL/RmAci2SvujYqInDVdUn/tcxJsNfsDgzLzVNrKCdrvEXPNp+l/fjSxQFRBhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=pvJXc7OO; arc=none smtp.client-ip=51.81.35.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
	by relay-us1.mymailcheap.com (Postfix) with ESMTPS id 6B209224EF;
	Thu, 11 Sep 2025 16:18:18 +0000 (UTC)
Received: from relay1.mymailcheap.com (relay1.mymailcheap.com [149.56.97.132])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id 3E1FF2080D;
	Thu, 11 Sep 2025 16:18:10 +0000 (UTC)
Received: from nf2.mymailcheap.com (nf2.mymailcheap.com [54.39.180.165])
	by relay1.mymailcheap.com (Postfix) with ESMTPS id 38E793E9B6;
	Thu, 11 Sep 2025 16:18:02 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf2.mymailcheap.com (Postfix) with ESMTPSA id D119B400AA;
	Thu, 11 Sep 2025 16:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1757607480; bh=e2daLt1V5mwDLfvAGnCZnTwhKH5st86SEoa+sdQ3cwY=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=pvJXc7OOKMED2ekAYpSqv4knHYjPwO5dDZlAKPC35VG+sb/VtDFXUl1NnqYrh1UXj
	 oqtSXUorEwrfscU8/9u2M4zcEMrV/eH3P395DK2FP6hwsrSKEbXFUe0CZeXuSaX2Y5
	 qv2uXDs7e95IXNUkJseNOzjItiidNbT6Xz/0iZN0=
Received: from [198.18.0.1] (unknown [183.95.75.61])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id BE34E41059;
	Thu, 11 Sep 2025 16:17:41 +0000 (UTC)
Message-ID: <35447ba0-21c2-4a12-9d27-033a7be0af3e@aosc.io>
Date: Fri, 12 Sep 2025 00:17:30 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] PCI: sg2042: Add Sophgo SG2042 PCIe driver
To: Chen Wang <unicornxw@gmail.com>, kwilczynski@kernel.org,
 u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 arnd@arndb.de, bwawrzyn@cisco.com, bhelgaas@google.com,
 unicorn_wang@outlook.com, conor+dt@kernel.org, 18255117159@163.com,
 inochiama@gmail.com, kishon@kernel.org, krzk+dt@kernel.org,
 lpieralisi@kernel.org, mani@kernel.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com, robh@kernel.org, s-vadapalli@ti.com,
 tglx@linutronix.de, thomas.richard@bootlin.com, sycamoremoon376@gmail.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
 sophgo@lists.linux.dev, rabenda.cn@gmail.com, chao.wei@sophgo.com,
 xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com
References: <cover.1757467895.git.unicorn_wang@outlook.com>
 <162d064228261ccd0bf9313a20288e510912effd.1757467895.git.unicorn_wang@outlook.com>
Content-Language: en-US
From: Mingcong Bai <jeffbai@aosc.io>
In-Reply-To: <162d064228261ccd0bf9313a20288e510912effd.1757467895.git.unicorn_wang@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D119B400AA
X-Rspamd-Server: nf2.mymailcheap.com
X-Spamd-Result: default: False [1.40 / 10.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[dt];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,baylibre.com,eecs.berkeley.edu,ghiti.fr,arndb.de,cisco.com,google.com,outlook.com,163.com,dabbelt.com,sifive.com,ti.com,linutronix.de,bootlin.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,sophgo.com];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[163.com,gmail.com,outlook.com];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hi Chen,

在 2025/9/10 10:08, Chen Wang 写道:
> +config PCIE_SG2042_HOST
> +	tristate "Sophgo SG2042 PCIe controller (host mode)"
> +	depends on OF && (ARCH_SOPHGO || COMPILE_TEST)
> +	select PCIE_CADENCE_HOST
> +	help
> +	  Say Y here if you want to support the Sophgo SG2042 PCIe platform
> +	  controller in host mode. Sophgo SG2042 PCIe controller uses Cadence
> +	  PCIe core.
> +

While build testing this patch against v6.16.6, PCIE_SG2042_HOST is set 
to "M", the kernel would fail to build during MODPOST:

ERROR: modpost: "cdns_pcie_pm_ops" 
[drivers/pci/controller/cadence/pcie-sg2042.ko] undefined!
make[2]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1
make[1]: *** [[...]/linux-6.16.6/Makefile:1953: modpost] Error 2
make: *** [Makefile:248: __sub-make] Error 2

Best Regards,
Mingcong Bai

