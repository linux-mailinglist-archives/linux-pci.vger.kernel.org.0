Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E36352A8139
	for <lists+linux-pci@lfdr.de>; Thu,  5 Nov 2020 15:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730775AbgKEOq1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Nov 2020 09:46:27 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:50927 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730465AbgKEOq1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Nov 2020 09:46:27 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 3D3EF750;
        Thu,  5 Nov 2020 09:46:26 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 05 Nov 2020 09:46:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=6C9J7IRGwUkF2mYifs9qqXtFfyq
        ahbJaolp0kaQj5k4=; b=43OLjuybVo5zIzuCqRNXCq47qhICivQVUqmi2l4RQvE
        xrgDWZ9qe/t+Gp1w9vB2c0WEg5Ocen6P8l7Jz8E3YIbFOsuGVBUv4+bB1x+CMTiE
        85OIPm7HLPOfvVrkbEfukRY0OjWwQQ0XE6MVoJvmKQiU4p3iCVFboa4t7NiWcrjJ
        KHCQt/WE/hCtlktG2Ehi4CA1q0LlzZKIvYnFmNtlfzO0t7fjTyZk9tXgTKs+hGtB
        jPmTSfRCuExJTwAPuhNd56kW+5T1G11zRqJMTAyvffbSV/C7psSJ0pytRep21wGG
        /p7mxZr/2jkDxFNv7WHk39Pf3/862VIuJi4FGD9RnZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=6C9J7I
        RGwUkF2mYifs9qqXtFfyqahbJaolp0kaQj5k4=; b=De01h8KxnJt4D5muJNgKO1
        kAYH26eecubzh6H52jm8y5rHRVYtjvAlp2h9d3Ne2GU9RbJWV/m1iLtpt6AEvbC8
        gKJ5EZrmCb7ACEQKXcua1WJUStYNpcY6t5Pi+vavi90C1gs7CIcT9XsLz0kqz7E0
        lMy6Trl0nDvwhV3fOTeB75wE/oClHq+MfM5AR52e/IJ8OZ5QGHZAjcSQsLYCnDwA
        wjdAxih4SVtcJ6lYpy0Bhe397+TT+RUX2KIiDmbLj0Xj7rxixUpa/O7MJls1NAl9
        tfreDD2FGdAWQpl/kSx0NSADZrL7xNtor+18Jv3yfoJB3ngs4QCJBGaXHb4bcSnw
        ==
X-ME-Sender: <xms:QRCkX9_CuhlcQ28hvslzEADrtmkQ_paJT2voMavQ1SXId9R9QHmhaA>
    <xme:QRCkXxtvIw_K398Po7QTkD_HTZGiSDaKXKRAprfMbg9yhU17HUdTD2Zp03Gy43wV0
    eBC2TO4Y2oYZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtjedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheq
    necuggftrfgrthhtvghrnhepveeuheejgfffgfeivddukedvkedtleelleeghfeljeeiue
    eggeevueduudekvdetnecukfhppeekfedrkeeirdejgedrieegnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtoh
    hm
X-ME-Proxy: <xmx:QRCkX7DoLBYyJjiN1j6rU5eIhY2keMduMljNVv6cU9L_qkOm7UPAKw>
    <xmx:QRCkXxefUDEi5F7YHC2ePhkfBnrcSpfG2Rrh-Qcw2-3tLnKgbFBlnA>
    <xmx:QRCkXyMrukVzhZ-BO1sYqS-JqUD8GoP_vD3DH330p33hb5fj28uujQ>
    <xmx:QRCkX8VrDNra9RmkYbNtwEadX5SL2pJZtmDc2fLRaMmy9I_ZANzk1Q>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id E47E632801F2;
        Thu,  5 Nov 2020 09:46:24 -0500 (EST)
Date:   Thu, 5 Nov 2020 15:47:11 +0100
From:   Greg KH <greg@kroah.com>
To:     Jack Winch <sunt.un.morcov@gmail.com>
Cc:     kernelnewbies <Kernelnewbies@kernelnewbies.org>,
        linux-pci@vger.kernel.org
Subject: Re: PCI / PCIe Device Memory - Rationale for Choosing MMIO Over PMIO
 (and Visa-Versa)
Message-ID: <20201105144711.GA427563@kroah.com>
References: <CAFhCfDbh0uXpTPu1+PQwk3_mV0uqfETynu=5yywU-U3CyDJGvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFhCfDbh0uXpTPu1+PQwk3_mV0uqfETynu=5yywU-U3CyDJGvA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 05, 2020 at 02:27:58PM +0000, Jack Winch wrote:
> Hi all,
> 
> Over the last couple of months, I've been reading the hardware
> documentation and Linux device driver source code for a range of
> different PCI and PCIe devices.  Those examined range from
> multi-function data acquisition cards through to avionics bus
> interface devices.  In doing so, I have referenced numerous resources
> (including the Third Edition of LDD - what a great book - and the
> documentation available for the Linux PCI Bus Subsystem on
> kernel.org).
> 
> One thing I'm still a little unclear on is why vendors might opt to
> map PCI / PCIe device memory into the system memory map as either
> Memory-Mapped I/O (MMIO) or Port-Mapped I/O (PMIO).  That is, for what
> reasons would a device manufacturer choose to make use of one address
> space over the other for regions of a PCI / PCIe device's memory?
> Some of the general reasons are alluded to by the aforementioned
> resources (e.g., more instruction cycles are required to access data
> via PMIO, MMIO can be marked as prefetchable and handled as such,
> etc).

I think you should be talking to hardware people about this, as this is
almost always due to hardware limitations/issues/design decisions.  The
PCI-SIG should have a bunch of resources about this, have you looked
into that?

good luck!

greg k-h
