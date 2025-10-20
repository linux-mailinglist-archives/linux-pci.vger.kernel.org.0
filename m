Return-Path: <linux-pci+bounces-38812-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C417BF3E86
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 00:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9FBCC4E0F57
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 22:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2E72D979F;
	Mon, 20 Oct 2025 22:33:32 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC2423EA85
	for <linux-pci@vger.kernel.org>; Mon, 20 Oct 2025 22:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760999612; cv=none; b=YayRazNIkSYz/UJVDRXblXrMAU1iCJtpoIaxwPZFE8TS0l6BUuIOHhcz3qOVZb6Wd6D/eltqkF9u9RKbYM91i4ufp//mCPpt/vbCfCT9XPIjj9FUXmdjF4kS/7ud3HZggBOTTh6GbwgkUeA5UT6sXzlX9fm+4RbZf6fqxqPhSCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760999612; c=relaxed/simple;
	bh=bIrTZvMRG1iWWic9WK5zbL7tmweu+85KbbrWy1ujtlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVBgXZYRZZ+VG3kTSsnSlnLI3RSJRrPDZXdeUcKJ38SSO1dJAbKiG9Xwx4VwXsee0ZSNBliC8Nde2auvu9+/622etIYzXh2fu3bTTXb6+GwZZ+U+eMaNB54IuaSgX+QdMgaxoBqN1Z3jVbx5YfhE0n0xMDWXM6GSGLd5q0QMQTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=avm99963.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=avm99963.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-426f7da0b64so430651f8f.2
        for <linux-pci@vger.kernel.org>; Mon, 20 Oct 2025 15:33:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760999609; x=1761604409;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sI46IxLQenYe3Bvaj7MAwN4y+wiSHGhgl4BxzQDCKn4=;
        b=ccGR62B/kYL4qGONXKFMdKJYJgqm2Lhl6TRN4ETfI+Lz9h9j5e58CTm3Y8PZEIHoFr
         ae8pIL2prgUfse5n9TIcECWZYMT1ynCHhC+h4ld1Vx+YUdzcyevEkZiJIOSystlAwF0O
         ktyl/2kYAT50Ob2bgG3GvFknU59YqN6BgKlCODr0Bcq03pPTtRqsVp/AVpMZmZzq+El7
         1Lxc0WCQcGZtLg/JgbeNyecje1cpJ1c7YXaigbSjUm28b5/B3YmrjWBchV/GX5rsqfjP
         y2WNafiryscPmCER7juJO1SnF02Z2zS+qtRWpQUzRUFlQSvdwMqVdGCbIvBktkaREZDH
         UecQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQT4gKmu1rFytqFlSpyd9Ydt06hsIoXPX86JnyVjf+/CR4aGVgbl8NjF6e+gQjijQe35LSCphfSIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ4YdWoX2q8QKoOhD/SzkURg9tXzbcNEFP7ShbGn9X0FNS18PN
	9Ff/zSwGLFr2IN30VziNEMpcLPSaFZZDpRP/U6qokDU4lqRYdmKhOVhU
X-Gm-Gg: ASbGnctVkGdOZbMboBylb5aRNfbLhuFLjLgof+k57Fic1KNY5XJ29zm1bTsQvPge+xP
	XHwuPTl4xZCaCJbdT3rHonM5h0oqb4m4hMuwgtkp2dzt+CK6QUXVuKN+bvOGf2JipY13Smyvsps
	6t8OUhNIMWFUQyrH2tMMJ//k1oAlF23fzDp6bD6Ro5iRlZwQrPffNaDE+MGoXPOxeHgi4e4r27D
	CACT6sLrEwyB1fDhmaoLt093/y46vPnCpHO9i1G9u4yL1NOeOgoldAquiWoB2KKuzXX7VlYQaCk
	gXm7J76Sjibu+nFnuRChAdsenhP+YH7eE14hyaqERP5a5Oc6t89NwejckquSHOELiKm/thKo2RK
	ZrYmQMSaouVfPkdUPq21ipO5T99tJxD7ojib+guOKy1D0V4RwsoqJZmMfxcwkLJEqYZMymABFAL
	8U2/d1uP5f7aQvK4jNnDcgEZDr4CZuL1CKPQ==
X-Google-Smtp-Source: AGHT+IETC3F/wmABgyq8kdA8EKubbpd94Rne05MH09yrcJYq/6GsCg9RKL7l5prbblzw8dt6ayscbA==
X-Received: by 2002:a05:600c:3b9d:b0:46e:5cb5:8ca2 with SMTP id 5b1f17b1804b1-474942bf7b2mr6296375e9.2.1760999608823;
        Mon, 20 Oct 2025 15:33:28 -0700 (PDT)
Received: from pixelbook (181.red-83-42-91.dynamicip.rima-tde.net. [83.42.91.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47496c43f68sm2876555e9.5.2025.10.20.15.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 15:33:28 -0700 (PDT)
Date: Tue, 21 Oct 2025 00:33:25 +0200
From: =?utf-8?Q?Adri=C3=A0_Vilanova_Mart=C3=ADnez?= <me@avm99963.com>
To: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, regressions@lists.linux.dev, 
	linux-pci@vger.kernel.org
Subject: Re: [REGRESSION] Intel Wireless adapter is not detected until
 suspending to RAM and resuming
Message-ID: <qbnpypp5uiowzuq5v7tqr67ptx2iv56pvmcnr3jmf4yxvhrvzf@auo7cmgtgbmd>
References: <owewi3sswao4jt5qn3ntm533lvxe3jlovhjbdufq3uedbuztxt@76nft22vboxv>
 <d0b6105f-744f-40d9-b4b7-1fa645038d0b@kernel.org>
 <h6wkxjrkxh3ea5aqexqrx4d6xb2t2xbirvznupnbgro64qytfs@mn2jg2c6owrj>
 <rvep55wtk2q4j46eqcxkfgb2bwijunefyltygfyb44trbzblx2@3ou3jcybjt3p>
 <6b3d282c-b3cd-4979-b26b-ae9b28b9d634@kernel.org>
 <kaieqe37mjmizjv4regyw67z7hwa3ac3k2mwcjsgq2mj7redpm@xsfb4mtyjblf>
 <a08c71e2-18ca-491b-8982-47214a35445b@kernel.org>
 <lpntymy3w6ryvyo2trpqkl7i3aibofzqcp7p5jhxjlkse645iq@fepikfj4tcyk>
 <149b04c5-23d3-4fd8-9724-5b955b645fbb@kernel.org>
 <60380893-c323-4d4c-a9a1-d43fcb4da1b3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <60380893-c323-4d4c-a9a1-d43fcb4da1b3@kernel.org>

On Mon, Oct 20, 2025 at 12:38:05PM -0500, Mario Limonciello (AMD) (kernel.org) wrote:
> 
> 
> On 10/20/2025 11:37 AM, Mario Limonciello (AMD) (kernel.org) wrote:
> > 
> > 
> > My interpretation is that the BIOS by default starts with PCI PM
> > enabled.  When you test without 4d4c10f763 and 907a7a2e5b it will stay
> > enabled.  But when those commits are present it gets disabled when going
> > to D0 and that causes device to drop off the bus.
> > 
> > How about with pcie_port_pm=off instead of pcie_aspm=off?  Do things work?

Nope, pcie_port_pm=off with a "bad" kernel results in the same issue,
and lspci still reports this:

        Capabilities: [200 v1] L1 PM Substates
                L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
                          PortCommonModeRestoreTime=40us PortTPowerOnTime=44us
                L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                           T_CommonMode=40us LTR1.2_Threshold=106496ns
                L1SubCtl2: T_PwrOn=60us

> > 
> > My current thought is that the change (setting to D0 explicitly at boot-
> > up) exposed a bug in the platform.  But the fact that it works without
> > ASPM is confusing to me.

Is there anything we could do to confirm this?

> > 
> > Bjorn - any thoughts here?
> 
> By happenstance I came across this earlier.
> 
> https://lore.kernel.org/linux-pm/aPJ4pZFENCTx9yhy@google.com/T/#m55aceae9153a1aa195635fe48aadb0888c795e49
> 
> Does that help by chance?

I tested this patch and its v2,[1] and none of them help.

Again, thank you so much!

[1]: https://lore.kernel.org/linux-pm/CAJZ5v0ie0Jz6AJdZJx2jNSRcqRQOqMCF+gYdgemTs=rKwXD1_g@mail.gmail.com

