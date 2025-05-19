Return-Path: <linux-pci+bounces-28007-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF4FABC599
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 19:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B74D67A5333
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 17:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992DB1F0E56;
	Mon, 19 May 2025 17:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pJpdYgOY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA1384A3E
	for <linux-pci@vger.kernel.org>; Mon, 19 May 2025 17:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747675725; cv=none; b=TG2pCFMk6cKWj2xT/A/c5stcenL7UxPaywn+rWKVUx6qmFKnxHghOgM1DAGQLEzx1c3Ksw2Z4NaVTvWjoxMjX+lpGAarCP9fQgwwkQG8i/VyJSjjrI4PmhGSeitZkgIOZL+xF6bUzoPjtScsLGiq6gMT2pYpRd/sua0iUXchFnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747675725; c=relaxed/simple;
	bh=O/UFOZHAExGShH0+O1xV4z8GLkWSwgE6zWujR6XuItQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMUHdCisLnkgtdQKmULMQ7rN7A0iJbl54o6P+vWOzpdqpFInbMNtCIIWkP2aIyelHGHC0kggRUVVXBVO3K3/mgqdYrbaZwB2l6s0u0UVV//OdKbnJJyBnYfmvWiF1qmiZyc7rPvad+t5Mw/hb/3qbc35hVGCtGWR6eam8OJYkZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pJpdYgOY; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6020053cbd5so863569a12.3
        for <linux-pci@vger.kernel.org>; Mon, 19 May 2025 10:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747675721; x=1748280521; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5NvM1mrCuK6F6Y9FKbHNHa0NhX9imJbIchh5fkAx/pk=;
        b=pJpdYgOYYDA0vY5ClPQlhyosQ0VMBEqMfBMH6gLkmh4ewPl0KrsQMGslQzLbTBRgGY
         Cwk05mccxmPeamarovrkDzhPtSyrbONWykm+fwadZDbdr6kUbxfnkRKmAdDU7XSSrAb8
         8tZTLPvA4B6BMUcdZbSdgG5zepmV5JnvgOVsGhogPhNgk3y2fOnKkC1PgNX0zbn6Fi12
         m+8n/rBtmI+DlWU5mQyMJ39okTgMMM64jMEobxUzOrk87ChPUW09DDqmqssiWnHvuII4
         569s1gjBK7xHnCr4MIyBCPtt73DNj4Ofb5r88Y5ZexIaucem3aZQ02PEXGcJVPXhDPn+
         Lb5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747675721; x=1748280521;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5NvM1mrCuK6F6Y9FKbHNHa0NhX9imJbIchh5fkAx/pk=;
        b=BTWf1DxoY0LUptf2OMsmcaNbcD8Fss6+JHC79sNFcO8PiuIXMwE7iiOouXh3/Ue/fu
         E8vAd4U9zYCGsELVYKSrTqljK5fFxl2gvxgWNjvplVv9ZcUHtfXXC+5lcR6BB12F2ANl
         GLo0yAQd8fweWvo1Xcb7w9y+kBlQAPrA67EvYCkiucdJLUyauK9OqASgpKKvAErEYenY
         w6vmvDkqDnx1H1fsm88PCucqV8AbPz9j6M2yaxu33WzhosKBHUb3agb8q6Yyg0+jas+a
         HuL5uTcMRD3yjd2alqAp5REH8BSXelTvZQxQQuUk6eldEo2X2dIAnk/YhonDVui9zy7E
         QWcw==
X-Forwarded-Encrypted: i=1; AJvYcCWede6+ztljN0Tj1QJfFyknXXu1jS0CR2StK6EnndtSzVOEz56qSPG81gG8B/+nqSB/hhZcYbsAsaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLCDHZyZwQjvK1wqrRSE39L+iJG1rkNjZR+WHPsYcFwLIWvhKF
	M+KWhbddI7Q8abj+77jYGeQXjHTBYkjaakfKuhnnAhPZR7jmIu/tEdYciIpvRWbwMw==
X-Gm-Gg: ASbGncv7iGl+ftkXOAtbR/+nFn0bpZIoYTaHMmwuWhoBG0+MA0qgK2Obi35/p0KrpJ/
	YDwXypdGQGDx4YbS9Xx9xsnzFiYvXEJ3LBCn8VLiUWcg7T9OB/rwgo5IJ2s6/5nGlheNHCq5iw8
	Bfn+4mF48OtNF/U5YxvAhGkG27V0NOYTbagKYS4GOEzntnlE18CNc4+lCl4LUH56JF2nIDcRH02
	BBLHqMAV6/BMcAJ0kGSRqw4Enxq6RZOlGy17JpSzoQiM2QM2aYXGacJ+LN9JGXhPcF/WuMZkcOy
	a1bPzkIUPIciPfL25D4gLv2DDoVwEx65lSHx5my2+to9+RIKO0DJmgiRwhsgcBY7oxNE37NKX0p
	Zx9KTBITM4ElflXEI22jXi1VFZgzLG3m0S69rQ207qMWO
X-Google-Smtp-Source: AGHT+IHeqvgUYRzdDmm30c27XY9n/sVqyYE35nRFAOCy/PRQEKNRooGEy5PUL9uU7bKszbjcjt2h3Q==
X-Received: by 2002:a05:6402:d0d:b0:5f3:4665:bfa5 with SMTP id 4fb4d7f45d1cf-60090154c3cmr12239356a12.33.1747675720916;
        Mon, 19 May 2025 10:28:40 -0700 (PDT)
Received: from thinkpad (host-87-20-215-169.retail.telecomitalia.it. [87.20.215.169])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6004d4f1c7esm5990012a12.14.2025.05.19.10.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 10:28:40 -0700 (PDT)
Date: Mon, 19 May 2025 18:28:39 +0100
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jim Quinlan <james.quinlan@broadcom.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>, 'Cyril Brulebois <kibi@debian.org>, 
	"maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" <bcm-kernel-feedback-list@broadcom.com>, 'Nicolas Saenz Julienne <nsaenz@kernel.org>, 
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: POSSIBLE REGRESSION: PCI/pwrctrl: Skip scanning for the device
 further if pwrctrl device is created
Message-ID: <k3mfsjktgzcekqgsioap3hxjvjrjl3hjb77zz3zdwji4t7jptp@yg4jt27pzjbx>
References: <CA+-6iNwgaByXEYD3j=-+H_PKAxXRU78svPMRHDKKci8AGXAUPg@mail.gmail.com>
 <20250519140557.GA1236950@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250519140557.GA1236950@bhelgaas>

On Mon, May 19, 2025 at 09:05:57AM -0500, Bjorn Helgaas wrote:
> On Mon, May 05, 2025 at 01:39:39PM -0400, Jim Quinlan wrote:
> > Hello,
> > 
> > I recently rebased to the latest Linux master
> > 
> > ebd297a2affa Linus.Torvalds Merge tag 'net-6.15-rc5' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
> > 
> > and noticed that PCI is broken for
> > "drivers/pci/controller/pcie-brcmstb.c"  I've bisected this to the
> > following commit
> > 
> > 2489eeb777af PCI/pwrctrl: Skip scanning for the device further if
> > pwrctrl device is created
> > 
> > which is part of the series [1].  The driver in pcie-brcmstb.c is
> > expecting the add_bus() method to be invoked twice per boot-up, but
> > the second call does not happen.  Not only does this code in
> > brcm_pcie_add_bus() turn on regulators, it also subsequently initiates
> > PCIe linkup.
> > 
> > If I revert the aforementioned commit, all is well.
> > 
> > FWIW, I have included the relevant sections of the PCIe DT we use at [2].
> 
> Mani, Bartosz, where are we at with this?  The 2489eeb777af commit log
> doesn't mention a problem fixed by that commit; it sounds more like an
> optimization -- just avoiding an unnecessary scan.
> 
> 2489eeb777af appeared in v6.15-rc1, so there's still time to revert it
> before v6.15 if that's the right way to fix this regression.
> 

We need to find out what is happening in the pcie-brcmstb driver first. From
Jim's report, it looks like the driver expects add_bus() callback to be invoked
twice, which seems weird.

If the fix takes time, then we can revert 2489eeb777af in the meantime.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

