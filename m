Return-Path: <linux-pci+bounces-18472-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A80BC9F2967
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 06:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C13EA16163B
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 05:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71A2189906;
	Mon, 16 Dec 2024 05:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mfw9C4oq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D0025632
	for <linux-pci@vger.kernel.org>; Mon, 16 Dec 2024 05:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734325717; cv=none; b=nzaf0XO8phgEHDV+GofAhyWohBwKy5PnRO17Uqy15AcRHZOz6Nv7yvY19ZdpjOKR0aY1ueCImNEnu3FkfCIV2l04bywjhjOpVM6Jws2xnfUQKtyDRVcuPHp0vnxYEAo4yc+sBweFytXs5AyqYJdIM8nLATpo38l6wegkndeukT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734325717; c=relaxed/simple;
	bh=2ju1IAEVBOrQUBDdBSs6KvnVdRWpmQIbD4ykKEu/9QA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vEo4yKd+fy+hn4VMiqFHuDbu9twYE0Ta75R4Cznmx1WqlEwKpOVj+xRys1G2c5RWgSbqrXQx7LQpZPBuIvn5ilNqTTTsENmSnYPC4eXnWMvGzOpeCzgkZ8GZ8e2SP+Dnp4t/F0zY82U0fq0IoSNPfhQH8Io/BOj7hDdQZ2FGTR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mfw9C4oq; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-8019f048bc7so2371926a12.1
        for <linux-pci@vger.kernel.org>; Sun, 15 Dec 2024 21:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734325715; x=1734930515; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Em/Cl1Un5rZGf3VhkwdnO0AI73Gmssn5wRijQz+hyu4=;
        b=Mfw9C4oqfe3nef2hI7K45gcz3EfhQZ8+gL0TcSH9QhZSf6yfNT9kgmb0EeEmOfuegf
         2ZQ21xYvWcXZol8U+5/mZJRWqN0UOYqtL7c8L1BZ3aB00p/uSBY/0Xcot4AMqcRyVS9U
         ay9VUL1Y6T/H5+97/x2st5pgQVwU0dxk/dBY9usJ9emgLQWJwII4EgKQObXaQbptZBdX
         Xwk+9UVPCSLSnJfVjB/eWtX7kmwbYxypIFA3yJx0h4/ZVzhzzmzlrWW9+74ooXu1ZMn7
         2Zz78rRWrRtxsqIVj8T8S1u/7Ew7HJGyRuJnUt85Z+FupZAxXZ8jEajXdz4EXc98ChC9
         6Pfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734325715; x=1734930515;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Em/Cl1Un5rZGf3VhkwdnO0AI73Gmssn5wRijQz+hyu4=;
        b=rBWjL00AbKbEMrS9Ce+qeIqXtJs9C5hckT++a1LJ+RshLHwpYyVyltva7zviwlaBt2
         1uolgxdvesdt3c6sy0H0e3xNV8zQ4pD2B2cJEuCu9FXDZMu7MWcOD+1HoUuS8AIigLqE
         33p9zMfXneGoHhfYUagpS9R3g0V7iqVT/KPVEZh+G+81AGpxnkm1Ut0GBmW8sMo2dLhC
         B8T4h9WrU/7wY3ksntXAe5zOE5gybxDyobvBC3pozvowT2iVS86gbM0OQKaIdP3q/KIT
         0NTUh60L9cbTnAln76dR4hdCA8wiYAmjHljaZgxGX/pdv6jf8UtE/oqCw1Mmc8zFfeWW
         pubw==
X-Forwarded-Encrypted: i=1; AJvYcCVUm+wlZGvEDlbHrD0g+59s9+p/V7YYXDtQCKKkiTE7PgncH3WEHvWPpE9yKDdQX3mC9065QISSXKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSU8yTFvieiyBOvFyQ2+501WvKvZPgGCR7QI0NSbD5ibjj6Czl
	hoZo7vb12JcagaKh1GHRXUfvsLNDATmJNm2d/DyZSCGc3cPV26ytHTm4ULXrCg==
X-Gm-Gg: ASbGncudrXNd8K4hoDvkiIm+0CFsQljKgue7qHbLE8TWt2pi3huEX82EtpjufgjQ5za
	rkyubxU5NwxV6S6cZLYBX6kH2hakgHMAXrGGmYf3J7AUyv+4GC4i81RgK+0ZQUFwq4TC2tdgflN
	o40EzUrEl1Ee88TVvt/hoSTximfqblSUlkNbN/ypqzIdKOU6K1AQ2yHLMSU2ElrWxFR2EkIXTD9
	AD/IHK5mphdsKlJL5YnQPoMylgAvMSreSRd+3kNw8en5yhRQ61yBzqvz/0iiDH83aM=
X-Google-Smtp-Source: AGHT+IGFLuaa872OiTpbwIJ12EZGTfvEXRUxI9S+oBeqTkwTJAML2INav9Us601kCggSsKLcDvu6cg==
X-Received: by 2002:a17:90b:4a09:b0:2ee:5bc9:75c7 with SMTP id 98e67ed59e1d1-2f28fa55c38mr16565074a91.5.1734325715065;
        Sun, 15 Dec 2024 21:08:35 -0800 (PST)
Received: from thinkpad ([120.60.56.176])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142fa1cd5sm7111817a91.34.2024.12.15.21.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 21:08:34 -0800 (PST)
Date: Mon, 16 Dec 2024 10:38:29 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Rob Herring <robh@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
	"open list:PCI DRIVER FOR GENERIC OF HOSTS" <linux-pci@vger.kernel.org>,
	"moderated list:PCI DRIVER FOR GENERIC OF HOSTS" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: check bridge->bus in pci_host_common_remove
Message-ID: <20241216050829.m4f5wqnzstsqqfcj@thinkpad>
References: <20241028084644.3778081-1-peng.fan@oss.nxp.com>
 <20241115062005.6ifvr6ens2qnrrrf@thinkpad>
 <PAXPR04MB8459D1507CA69498D8C38E0488242@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <20241115144720.ovsyq2ani47norby@thinkpad>
 <20241127195650.GA4132105-robh@kernel.org>
 <20241202092902.rp6xb3f64llpabbi@thinkpad>
 <CAL_Jsq+R39jtCeDecpEHbKq+4N-uirMQmsuNG1NaVe1Vnnnv3Q@mail.gmail.com>
 <20241215132640.GA2476@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241215132640.GA2476@localhost.localdomain>

On Sun, Dec 15, 2024 at 09:26:40PM +0800, Peng Fan wrote:
> Hi Rob,
> 
> On Mon, Dec 02, 2024 at 07:55:27AM -0600, Rob Herring wrote:
> >On Mon, Dec 2, 2024 at 3:29 AM Manivannan Sadhasivam
> ><manivannan.sadhasivam@linaro.org> wrote:
> >>
> >> On Wed, Nov 27, 2024 at 01:56:50PM -0600, Rob Herring wrote:
> >> > On Fri, Nov 15, 2024 at 08:17:20PM +0530, Manivannan Sadhasivam wrote:
> >> > > On Fri, Nov 15, 2024 at 10:14:10AM +0000, Peng Fan wrote:
> >> > > > Hi Manivannan,
> >> > > >
> >> > > > > Subject: Re: [PATCH] PCI: check bridge->bus in
> >> > > > > pci_host_common_remove
> >> > > > >
> >> > > > > On Mon, Oct 28, 2024 at 04:46:43PM +0800, Peng Fan (OSS) wrote:
> >> > > > > > From: Peng Fan <peng.fan@nxp.com>
> >> > > > > >
> >> > > > > > When PCI node was created using an overlay and the overlay is
> >> > > > > > reverted/destroyed, the "linux,pci-domain" property no longer exists,
> >> > > > > > so of_get_pci_domain_nr will return failure. Then
> >> > > > > > of_pci_bus_release_domain_nr will actually use the dynamic IDA,
> >> > > > > even
> >> > > > > > if the IDA was allocated in static IDA. So the flow is as below:
> >> > > > > > A: of_changeset_revert
> >> > > > > >     pci_host_common_remove
> >> > > > > >      pci_bus_release_domain_nr
> >> > > > > >        of_pci_bus_release_domain_nr
> >> > > > > >          of_get_pci_domain_nr      # fails because overlay is gone
> >> > > > > >          ida_free(&pci_domain_nr_dynamic_ida)
> >> > > > > >
> >> > > > > > With driver calls pci_host_common_remove explicity, the flow
> >> > > > > becomes:
> >> > > > > > B pci_host_common_remove
> >> > > > > >    pci_bus_release_domain_nr
> >> > > > > >     of_pci_bus_release_domain_nr
> >> > > > > >      of_get_pci_domain_nr      # succeeds in this order
> >> > > > > >       ida_free(&pci_domain_nr_static_ida)
> >> > > > > > A of_changeset_revert
> >> > > > > >    pci_host_common_remove
> >> > > > > >
> >> > > > > > With updated flow, the pci_host_common_remove will be called
> >> > > > > twice, so
> >> > > > > > need to check 'bridge->bus' to avoid accessing invalid pointer.
> >> > > > > >
> >> > > > > > Fixes: c14f7ccc9f5d ("PCI: Assign PCI domain IDs by ida_alloc()")
> >> > > > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> >> > > > >
> >> > > > > I went through the previous discussion [1] and I couldn't see an
> >> > > > > agreement on the point raised by Bjorn on 'removing the host bridge
> >> > > > > before the overlay'.
> >> > > >
> >> > > > This patch is an agreement to Bjorn's idea.
> >> > > >
> >> > > > I have added pci_host_common_remove to remove host bridge
> >> > > > before removing overlay as I wrote in commit log.
> >> > > >
> >> > > > But of_changeset_revert will still runs into pci_host_
> >> > > > common_remove to remove the host bridge again. Per
> >> > > > my view, the design of of_changeset_revert to remove
> >> > > > the device tree node will trigger device remove, so even
> >> > > > pci_host_common_remove was explicitly used before
> >> > > > of_changeset_revert. The following call to of_changeset_revert
> >> > > > will still call pci_host_common_remove.
> >> > > >
> >> > > > So I did this patch to add a check of 'bus' to avoid remove again.
> >> > > >
> >> > >
> >> > > Ok. I think there was a misunderstanding. Bjorn's example driver,
> >> > > 'i2c-demux-pinctrl' applies the changeset, then adds the i2c adapter for its
> >> > > own. And in remove(), it does the reverse.
> >> > >
> >> > > But in your case, the issue is with the host bridge driver that gets probed
> >> > > because of the changeset. While with 'i2c-demux-pinctrl' driver, it only
> >> > > applies the changeset. So we cannot compare both drivers. I believe in your
> >> > > case, 'i2c-demux-pinctrl' becomes 'jailhouse', isn't it?
> >> > >
> >> > > So in your case, changeset is applied by jailhouse and that causes the
> >> > > platform device to be created for the host bridge and then the host bridge
> >> > > driver gets probed. So during destroy(), you call of_changeset_revert() that
> >> > > removes the platform device and during that process it removes the host bridge
> >> > > driver. The issue happens because during host bridge remove, it calls
> >> > > pci_remove_root_bus() and that tries to remove the domain_nr using
> >> > > pci_bus_release_domain_nr().
> >> > >
> >> > > But pci_bus_release_domain_nr() uses DT node to check whether to free the
> >> > > domain_nr from static IDA or dynamic IDA. And because there is no DT node exist
> >> > > at this time (it was already removed by of_changeset_revert()), it forces
> >> > > pci_bus_release_domain_nr() to use dynamic IDA even though the IDA was initially
> >> > > allocated from static IDA.
> >> >
> >> > Putting linux,pci-domain in an overlay is the same problem as aliases in
> >> > overlays[1]. It's not going to work well.
> >> >
> >> > IMO, you can have overlays, or you can have static domains. You can't
> >> > have both.
> >> >
> >>
> >> Okay.
> >>
> >> > > I think a neat way to solve this issue would be by removing the OF node only
> >> > > after removing all platform devices/drivers associated with that node. But I
> >> > > honestly do not know whether that is possible or not. Otherwise, any other
> >> > > driver that relies on the OF node in its remove() callback, could suffer from
> >> > > the same issue. And whatever fix we may come up with in PCI core, it will be a
> >> > > band-aid only.
> >> > >
> >> > > I'd like to check with Rob first about his opinion.
> >> >
> >> > If the struct device has an of_node set, there should be a reference
> >> > count on that node. But I think that only prevents the node from being
> >> > freed. It does not prevent the overlay from being detached. This is one
> >> > of many of the issues with overlays Frank painstakingly documented[2].
> >> >
> >>
> >> Ah, I do remember this page as Frank ended up creating it based on my
> >> continuous nudge to add CONFIG_FS interface for applying overlays.
> >>
> >> So why are we applying overlays in kernel now?
> >
> >That's been the case for some time. Mostly it's been for fixups of old
> >to new bindings, but those all got dropped at some point. The in
> >kernel users are very specific use cases where we know something about
> >what's in the overlay. In contrast, configfs interface allows for any
> >change to any node or property with no control over it by the kernel.
> >Never say never, but I just don't see that ever happening upstream.
> 
> So should I switch to use configfs for jailhouse case? Currently
> we use overlay to add a virtual pci node to kernel device tree.
> 

Not at all. I think you have 2 options:

1. Get rid of 'linux,pci-domain' from overlay and rely on static id allocation.
2. Make sure the driver is unbind for each device before removing the overlays.

Options 1 is to avoid your issue and option 2 is to fix your issue. You can
decide which one to opt for :)

- Mani

-- 
மணிவண்ணன் சதாசிவம்

