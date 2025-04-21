Return-Path: <linux-pci+bounces-26334-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE80A95319
	for <lists+linux-pci@lfdr.de>; Mon, 21 Apr 2025 16:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 943BD1883BF1
	for <lists+linux-pci@lfdr.de>; Mon, 21 Apr 2025 14:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C06149DE8;
	Mon, 21 Apr 2025 14:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YwLdwQCL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E8A139D0A
	for <linux-pci@vger.kernel.org>; Mon, 21 Apr 2025 14:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745247206; cv=none; b=h6UGrUFwIwXI91RuVWi9PTFzbOGAvxt1dsDeP0S1kOMnABrguW4sOVu74U4RvWeTBBKOawg0rhUrRSuuWDo+8u8FibsTRgkNozJNsD4MHLydAvflkk4cnkfGH5MoLk017zd2sKUfaGJAdLQFOfB21qmV5/4GmYYGEFmN8PV2Jx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745247206; c=relaxed/simple;
	bh=LESRlj7KZifRMRVlVUCzrnfPDG7wPoAe3hzr240OKMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lu0JRpgM3DPDctl9ukiySHx4gkJ5vZ0DhK5VBHs5OmZAD5j4+erJEyOOhbe4tOug9f8VoGRTtjarjQNUltxhqWvdpwVExrQ4RUYp1KHDshpVwWq254ANavDIx0u/+B8nAoR9yS7636es3Vtjf62V7yiLP5+P8s+FNRdvXs9e05w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YwLdwQCL; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22423adf751so41132155ad.2
        for <linux-pci@vger.kernel.org>; Mon, 21 Apr 2025 07:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745247204; x=1745852004; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TNHDYvZ+kXQIgJtW4CpMeV/F9LD9o9x0KLwHdWA+41Y=;
        b=YwLdwQCLAEWov1T7OWgmzy8gc0Rnqw4l22N21GWsj5cg8iUdCRnDorD51iL751VAhS
         EoQQEL2mjF6lN7ly6poJeXis3HhS81SKaQ2gVdiT4bQJfPmB3xd3niPn9ge7u5bnyqX8
         zGtmiFbXDOjlEQH9qCa8PYeSIA3BXhtV9lJ8NiB8qufmwU9TZ4UTvxZs5r3BpKY85VVR
         0GK/Ty3sVYUllgwalPDZwHJCa/AapQ8l2eTGlboNb1xTSMg8Jy/aFgJSRAqVZvp7koo5
         cQvgmqPcDu1JoJr8jTSG9zEhlcDwxO4SiX5oKk1gA4HaujFHpakd+HyNmo5iGKC18eVr
         fu7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745247204; x=1745852004;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TNHDYvZ+kXQIgJtW4CpMeV/F9LD9o9x0KLwHdWA+41Y=;
        b=qQGn20eEFxToOWToUYZbqULANw3pddqNY79CLJ/Pv98RdsbuW8pt5k/8uOudjuBp8l
         p2gHDnInYIRmVxvB8tfTXoqYvzBbnAZKylyjxD9gR/0BHtFB2DYZCJVDYlZ6kB0ofSUP
         jEk3i0YGD343nYc/FcvsZx+crzi57Z1vE+CffT/r1WKXY/eeF92Nolh47Es01xXlHj4I
         spsB8KMEMsGQT84LamJGZNzBDYLzDogkfIHzKnEVlCOLRtXk/dqqUXymLDv6l1dNpsez
         kVE9Yc+a2SzP8Grgl7Fk8ILcyrYZ3F2A1MFqGCbC2YZEyVXgVQLUmUJLPJlzlJs6Vm1W
         SnaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrvvTmzb2UK9AYhovLx2UQrEahMWaymCFJdoP+/FxVOx98qwHeHRGTL3N+TudICdcHu05LjDnynFg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx31yw+W6y8vcEpucsj/uDCquVJdrI5OiCN68Q9j5DgEdvXfcXq
	hyi00zIHxmgwu7EVYiyMiaJ8dD4AZY8bqIeMUnyj08ryQlUY7tHiYXYICkbjng==
X-Gm-Gg: ASbGncv0Z24lDOSyPbR1I4R1uB12FINK3SQluju965bWQVzQRwxbnnum2sCEyrXDzSY
	C/yjUJT9IzwFF0uFCCZJGZfrh2Lsyd+6VJo4ANc9jK+f58ds+D+ZXKjQno2b87wdkjoKS/2XHjF
	2n6BewY0MOPIY2rD8NaPuxIYyAuJyq04FCJgNzyeY+2EFNUTp8svVTkm7M1x2P/wXxKxbTxqwvt
	qK84UayCCLYr3yIaMJfg3+dOihGnbqdfbCzDHEO8E+gE/Jk91fy4NRGL1m/xb42rHO0eJWUgz7X
	x9NvieYY0Db89g6KddwyoIdFzRBzeJG8SeVcf8iB5CqrVVw07h+B
X-Google-Smtp-Source: AGHT+IEFdCxUF0IGkc39Y6ivCpK40FOP5pObjbZbRz+JR102E0UDzHVcUjHWjvl2BLeEpo3bJDhIxA==
X-Received: by 2002:a17:903:228f:b0:223:653e:eb09 with SMTP id d9443c01a7336-22c5356e485mr145692145ad.7.1745247203811;
        Mon, 21 Apr 2025 07:53:23 -0700 (PDT)
Received: from thinkpad ([120.56.203.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50ecec61sm66006875ad.182.2025.04.21.07.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 07:53:23 -0700 (PDT)
Date: Mon, 21 Apr 2025 20:23:18 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Hans Zhang <18255117159@163.com>
Cc: Niklas Cassel <cassel@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, 
	Shawn Lin <shawn.lin@rock-chips.com>, lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com, 
	heiko@sntech.de, robh@kernel.org, jingoohan1@gmail.com, 
	thomas.richard@bootlin.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] PCI: dw-rockchip: Configure max payload size on host init
Message-ID: <vc6z6pzgk2sjgkghnwfzlmj3dblrvpkfnsmnlb2nnkj2leju7t@uxy3kthse7g6>
References: <20250417165219.GA115235@bhelgaas>
 <22720eef-f5a3-4e72-9c41-35335ec20f80@163.com>
 <225CC628-432C-4E88-AF2B-17C948B3790B@kernel.org>
 <8af8a418-b808-4a14-9969-1c6d549e1633@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8af8a418-b808-4a14-9969-1c6d549e1633@163.com>

On Sat, Apr 19, 2025 at 01:21:54AM +0800, Hans Zhang wrote:
> 
> 
> On 2025/4/18 22:55, Niklas Cassel wrote:
> > 
> > 
> > On 18 April 2025 14:33:08 CEST, Hans Zhang <18255117159@163.com> wrote:
> > > 
> > > Dear Bjorn,
> > > 
> > > Thanks your for reply. Niklas and I attempted to modify the relevant logic in drivers/pci/probe.c and found that there was a lot of code judging the global variable pcie_bus_config. At present, there is no good method. I will keep trying.
> > > 
> > > I wonder if you have any good suggestions? It seems that the code logic regarding pcie_bus_config is a little complicated and cannot be modified for the time being?
> > 
> > 
> > Hans,
> > 
> > If:
> > 
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 364fa2a514f8..2e1c92fdd577 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -2983,6 +2983,13 @@ void pcie_bus_configure_settings(struct pci_bus *bus)
> >           if (!pci_is_pcie(bus->self))
> >                   return;
> >    +       /*
> > +        * Start off with DevCtl.MPS == DevCap.MPS, unless PCIE_BUS_TUNE_OFF.
> > +        * This might get overriden by a MPS strategy below.
> > +        */
> > +       if (pcie_bus_config != PCIE_BUS_TUNE_OFF)
> > +               smpss = pcie_get_mps(bus->self);
> > +
> 
> Dear Niklas,
> 
> Thank you very much for your reply and thoughts.
> 
> pcie_get_mps: Returns maximum payload size in bytes
> 
> I guess you want to obtain the DevCap MPS. But the purpose of the smpss
> variable is to save the DevCtl MPS.
> 
> >           /*
> >            * FIXME - Peer to peer DMA is possible, though the endpoint would need
> >            * to be aware of the MPS of the destination.  To work around this,
> > 
> > 
> > 
> > does not work, can't you modify the code slightly so that it works?
> > 
> > I haven't tried myself, but considering that it works when walking the bus, it seems that it should be possible to get something working.
> > 
> 
> 
> After making the following modifications, my test shows that it is normal.
> If the consideration is not comprehensive. Could Bjorn and Niklas please
> review my revisions?
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 364fa2a514f8..5b54f1b0a91d 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2951,8 +2951,7 @@ static int pcie_bus_configure_set(struct pci_dev *dev,
> void *data)
>         if (!pci_is_pcie(dev))
>                 return 0;
> 
> -       if (pcie_bus_config == PCIE_BUS_TUNE_OFF ||
> -           pcie_bus_config == PCIE_BUS_DEFAULT)
> +       if (pcie_bus_config == PCIE_BUS_TUNE_OFF)
>                 return 0;
> 
>         mps = 128 << *(u8 *)data;
> @@ -2991,7 +2990,8 @@ void pcie_bus_configure_settings(struct pci_bus *bus)
>         if (pcie_bus_config == PCIE_BUS_PEER2PEER)
>                 smpss = 0;
> 
> -       if (pcie_bus_config == PCIE_BUS_SAFE) {
> +       if ((pcie_bus_config == PCIE_BUS_SAFE) ||
> +           (pcie_bus_config != PCIE_BUS_TUNE_OFF)) {
>                 smpss = bus->self->pcie_mpss;
> 
>                 pcie_find_smpss(bus->self, &smpss);
> 
> 

As I replied to Niklas, I'd like to limit the changes to platforms having
controller drivers. So here is my proposal:

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 364fa2a514f8..d32a0f90beb1 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3228,6 +3228,17 @@ int pci_host_probe(struct pci_host_bridge *bridge)
         */
        pci_assign_unassigned_root_bus_resources(bus);
 
+       if (pcie_bus_config != PCIE_BUS_TUNE_OFF) {
+               /* Configure root ports MPS to be MPSS by default */
+               for_each_pci_bridge(dev, bus) {
+                       if (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT)
+                               continue;
+
+                       pcie_write_mps(dev, 128 << dev->pcie_mpss);
+                       pcie_write_mrrs(dev);
+               }
+       }
+
        list_for_each_entry(child, &bus->children, node)
                pcie_bus_configure_settings(child);

- Mani

-- 
மணிவண்ணன் சதாசிவம்

