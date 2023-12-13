Return-Path: <linux-pci+bounces-868-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5421B810F33
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 12:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85F821C208C8
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 11:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB68622F0F;
	Wed, 13 Dec 2023 11:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="Kqien4/w";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="y9f7Qfs8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBCEDB
	for <linux-pci@vger.kernel.org>; Wed, 13 Dec 2023 03:01:08 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 078E7C0008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1702465267; bh=6m9NSKssRLldmWlhixuV2oOzYiZ/x4bVdnHRpPmniAk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=Kqien4/wm5k10ccVsDpY2hvkjjj2HNVg+lLYanQ9UApQ7CRd9lFkrLlCRrIhgCabt
	 8SVbvq5aiv0W2mrjJCwHBQaP4B4g6XUa75mElpjqBvmze82nBefO9VlgZHt+282gLq
	 cwyFuljUIcbgjVTNqtpZcvhMXLDY9GVi/Em+M1dNBEoOVXB1jUPXIvoeFcd4HW/jX6
	 7xpJW2d0quCgk3xHsZ7Cdb5OXgBNf4iLRsZ8Tgfg0fWibzWcpys8EWJvSDkCARknUF
	 NI04lfmIoThhO/RnzMjOiEZYH/pZIHDdlFeKIYouX5MsrYRgJtDbwWkxtJb8f/RLmk
	 Y5BNfwLOQcrhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1702465267; bh=6m9NSKssRLldmWlhixuV2oOzYiZ/x4bVdnHRpPmniAk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=y9f7Qfs84di7TzxK57mrzLMh2aMWgxVqoepvRIYPATtQP33P5nxADCpF/wqM1oYqu
	 6ac8WrdYi2OROMlnF4/wF1LGvCtOXWm9Vm7COUgw66GtIO8EYB4vFfqchz/ipnSsxW
	 2zfYu1Lu8JT2fXPZQfFhLl/UGbeUau9QrpICSOdcI8erUKZSxCpw/liRYNAsSDXgIY
	 LRzAlsXop4MJdX82fbipEVbf9VsK//NpvziuP6udYUs6KUSl/eIcvItLfaeoFbG16T
	 L097aGPBJwOCgR2Ns8iBkxMCmpmd3tIV6VpZx6N3iZpc7Yvyy3zYxK4rl7NA7x4dj8
	 mzi+C3mk/gcsQ==
Date: Wed, 13 Dec 2023 14:01:04 +0300
From: Nikita Proshkin <n.proshkin@yadro.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <linux-pci@vger.kernel.org>, Martin Mares <mj@ucw.cz>, <linux@yadro.com>,
	Sergei Miroshnichenko <s.miroshnichenko@yadro.com>, Nikita Proshkin
	<n.proshkin@yadro.com>
Subject: Re: [PATCH 15/15] pciutils-pcilmr: Add pcilmr man page
Message-ID: <20231213140104.075c89bd.n.proshkin@yadro.com>
In-Reply-To: <20231208172404.GA797244@bhelgaas>
References: <20231208091734.12225-16-n.proshkin@yadro.com>
	<20231208172404.GA797244@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: T-EXCH-10.corp.yadro.com (172.17.11.60) To
 T-EXCH-08.corp.yadro.com (172.17.11.58)

Hello Bjorn,
Thanks for the review!

On Fri, 8 Dec 2023 11:24:04 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> I'm not a hardware person, but this looks like interesting work!
> 
> On Fri, Dec 08, 2023 at 12:17:34PM +0300, Nikita Proshkin wrote:
> > +Turn off PCIE Leaky Bucket Feature, Re-Equalization and Link Degradation;
> 
> s/PCIE/PCIe/ to match other uses here.
> 
> > +The current Link data rate must be 16.0 GT/s or higher (right now
> > +utility supports Gen 4 and 5 Links);
> 
> So far, each major PCIe spec revision has added a single new data
> rate, but that may not always be true, and the spec always uses
> terminology like "16.0 GT/s or higher" instead of terms like "Gen 4".
> 
> So "supports 16.0 GT/s and 32.0 GT/s Links" might be clearer.
> 
> > +The Gen 5 Specification sets allowed range for Timing Margin from 20%\~UI to 50%\~UI and
> 
> Usage in the spec itself would be more like "PCIe Base Spec Revision 5.0"
> since it doesn't use "Gen 5".
> 
> > +According to spec it's possible for Receiver to margin up to MaxLanes + 1
> > +lanes simultaneously, but usually this works bad, so this option is for
> 
> s/works bad/works poorly/
> 
> > +experiments mostly.

Got it, I will style check the Man page again.

Best regards,
Nikita Proshkin

