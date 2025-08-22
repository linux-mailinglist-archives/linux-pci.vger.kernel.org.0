Return-Path: <linux-pci+bounces-34610-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC06B320CD
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 18:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BE66172BE9
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 16:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0557730DEC5;
	Fri, 22 Aug 2025 16:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOldZ6P4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA5A307ACD;
	Fri, 22 Aug 2025 16:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755881475; cv=none; b=gRlRg+MjupceW/WT+z8guFZxGUinttJXNpSQ3Xx8nGCbGMRcnVr7hM+/qvRcR71iU7hZLUAcW8JRG+7MMbvCGcF+BXbulmxap/c7f04N2Vve95Sm4GPJZg3p34nT47AZ8ptvnORadiuSgkkdE/Of8URx+p1f/rxXrrwWzr08LWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755881475; c=relaxed/simple;
	bh=ZN1/GSSsUnr11TA2ChLgQXw36yoz98xor8JyYYUMooQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Jtl/J3BnYQir1ajBt0Nf5+LzYprrQnu2tD6Qm1zuVz4wMUdvJEJj0CgPMoHAVK6tljGMMhTnClcv8zPTKYFBSgYeckcqcDmvKP8Gamfo9bjuU315FTvG3N9wCG4gJmJROrlqSfwLoU4kmJHTqsZaYBtFSovOuFIy4jFsvVooQus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOldZ6P4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E68FDC4CEED;
	Fri, 22 Aug 2025 16:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755881475;
	bh=ZN1/GSSsUnr11TA2ChLgQXw36yoz98xor8JyYYUMooQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=TOldZ6P4XjDi8geWUHI4dDlTT6CJl79l8sxl1DywRr/cP9kB878+0JkMA/VKU4RXH
	 0/0bkecaXvUt55YZXuEbcOHw0QQEAL1sp9aA5eSUXoQNTKa+vwliCqVYL132XwqGYX
	 jOyAVQR7WyYfW21GVtx8cGUCtlMYTOf2rrGtTRMmP3JH/EUTBqXjGU16IcKqKz7gzU
	 ii4KkNruWP1ZjXjkv4hjXC3g1ALdUqATnnaexhDPwrJkflTfRAVA//GsLljIjaCxjq
	 C5TibyaJM2cpWRRjFBbRv2JHLBft3EPEvwjfn3TexdNBE3CTT4r1jCt/Xf9RETQSvX
	 CWUdvouXz1saw==
Date: Fri, 22 Aug 2025 11:51:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: "Carlis, Matthew" <mattc@purestorage.com>,
	"Smita.KoralahalliChannabasappa@amd.com" <Smita.KoralahalliChannabasappa@amd.com>,
	"Preble, Adam C" <adam.c.preble@intel.com>,
	"Schofield, Alison" <alison.schofield@intel.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"Peng, Chao P" <chao.p.peng@intel.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>,
	"Jiang, Dave" <dave.jiang@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>,
	"erwin.tsaur@intel.com" <erwin.tsaur@intel.com>,
	"Wanyan, Feiting" <feiting.wanyan@intel.com>,
	"Weiny, Ira" <ira.weiny@intel.com>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"lukas@wunner.de" <lukas@wunner.de>,
	"mahesh@linux.ibm.com" <mahesh@linux.ibm.com>,
	"oohall@gmail.com" <oohall@gmail.com>,
	"qingshun.wang@linux.intel.com" <qingshun.wang@linux.intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"rrichter@amd.com" <rrichter@amd.com>,
	"Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
	"Luck, Tony" <tony.luck@intel.com>,
	"Verma, Vishal L" <vishal.l.verma@intel.com>,
	"Wang, Yudong" <yudong.wang@intel.com>,
	"Saggi, Meeta" <msaggi@purestorage.com>,
	"sconnor@purestorage.com" <sconnor@purestorage.com>,
	"Karkare, Ashish" <ashishk@purestorage.com>,
	"rhan@purestorage.com" <rhan@purestorage.com>,
	"Rangi, Jasjeet" <jrangi@purestorage.com>,
	"Govindjee, Arjun" <agovindjee@purestorage.com>,
	"Amstadt, Bob" <bamstadt@purestorage.com>
Subject: Re: [PATCH v5 0/2] PCI/AER: Handle Advisory Non-Fatal error
Message-ID: <20250822165112.GA688464@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA3PR11MB9136FCB8C778B0AE08BF8DB5923DA@IA3PR11MB9136.namprd11.prod.outlook.com>

On Fri, Aug 22, 2025 at 01:45:30AM +0000, Duan, Zhenzhong wrote:
> Hi Matthew,
> 
> Feel free to take it over if you are interested. Maintainer didn't
> respond to this series, perhaps he expects some improvement in the
> series.

I'm terribly sorry, this is my fault.  It just fell off my list for no
good reason.  Matthew, if you are able to test and/or provide a
Reviewed-by, that would be the best thing you can do to move this
forward (although neither is actually necessary).

Bjorn

> >-----Original Message-----
> >From: Matthew W Carlis <mattc@purestorage.com>
> >Subject: [PATCH v5 0/2] PCI/AER: Handle Advisory Non-Fatal error
> >
> >Hello. My team had independently started to make a change similar to this
> >before realizing that someone had already taken a stab at it. It is highly
> >desirable in my mind to have an improved handling of Advisory Errors in
> >the upstream kernel. Is there anything we can do to help move this effort
> >along? Perhaps testing? We have a decent variety of system configurations &
> >are able to inject various kinds of errors via special devices/commands etc.
> >
> >Thanks,
> >-Matt

