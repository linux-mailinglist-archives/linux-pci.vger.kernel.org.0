Return-Path: <linux-pci+bounces-20960-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41344A2CEE2
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 22:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61B6F1889E4F
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 21:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841071ACEDF;
	Fri,  7 Feb 2025 21:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHiCCVLq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB4419C578;
	Fri,  7 Feb 2025 21:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738962792; cv=none; b=h0Km7/90taeWAkxovX4Sz6sJMjVUAUfi8IgK7qKzfW800ZGiSUCsahg5l/A+DFKHR34OEgwdmctowrDGu4ByaRgO5dH1pebk30yqGOOSoZvwChkhaLFBwsi6Mbpl0wF4puCiRKWj7uGR6A6Fn/UQqncpupHy5nyg3IMLe9qol6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738962792; c=relaxed/simple;
	bh=iLJR8r/FtzvblXPrOP6zWtxCuI9Qji2JVGmG1w2R+KI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhQ0m8CQTgWRuEc4z6G9Ai1JHtfpiYQWWidMwKNHf0uSnRg/JchLRxD05ZqipRathtY0orXK7o4E3TN44yIIEk9gz0lIGu9QpAc/lRJ2+iFkiuMOxLY3oVNx4D15y1PFpeyt/a/xKWloNKS5kf/ewj1Vz3xhe1Npjn11Ujf5Ou4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHiCCVLq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23602C4CEE2;
	Fri,  7 Feb 2025 21:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738962791;
	bh=iLJR8r/FtzvblXPrOP6zWtxCuI9Qji2JVGmG1w2R+KI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WHiCCVLqz4V+ld3x8T62EsIheZdG9ugIWnBAn4q47Z5Rs9Wkhb5lx1qfmHlzAewPr
	 bZD19Lbcn2IoR8nQtj/Z7dqUCeQUnetD+SL7sdTqO9L8HWZIvWH8hwc+Mp37L2TFMr
	 /wUHlr+4De++G5oEzMKgUExo3ukFSs32Hp4f5nH7V6pRw92SMCRJ6W/1iSUTvO1IZq
	 jF4JYwU4r0DSHqSiyqg6tCv0I1QCPKLa4dGPcxXEsQhYJOChXn+UvRLZVP5XeoFznK
	 fP21IX/8jSoYu/UtWq7m+Q4cVxFD2fDpbkt1B7XtOYJMhe8SpuF16EIAW7aqjQc5Qx
	 YkC/gyfibE/2g==
Date: Fri, 7 Feb 2025 22:13:06 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Wilson Ding <dingwei@marvell.com>, Bjorn Helgaas <helgaas@kernel.org>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Sanghoon Lee <salee@marvell.com>
Subject: Re: [PATCH 1/1] PCI: armada8k: Add link-down handle
Message-ID: <Z6Z3YgruoFyIThE0@x1-carbon>
References: <20241112213255.GA1861331@bhelgaas>
 <AD287CCE-9FFE-49BC-B9CA-B5CED4F05AF1@linaro.org>
 <BY3PR18MB46737FB5FDBD75CF31B505B8A7EB2@BY3PR18MB4673.namprd18.prod.outlook.com>
 <BY3PR18MB4673207A36B2CD7C3B75EBA0A7EB2@BY3PR18MB4673.namprd18.prod.outlook.com>
 <20250207175759.jzmoox5mke3rachy@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207175759.jzmoox5mke3rachy@thinkpad>

On Fri, Feb 07, 2025 at 11:27:59PM +0530, Manivannan Sadhasivam wrote:
> + Niklas (who was interested in link down handling)

I am still interested :)


> On Sat, Feb 01, 2025 at 11:05:56PM +0000, Wilson Ding wrote:
> 
> > In the meanwhile, I am quite interested the callback implementation suggested
> > by Mani. But I am sure if we have such infrastructure right there. Mani, could
> > you please elaborate a bit more, or is there any examples in the existing code
> > and patches.
> > 
> 
> There is no such implementation available right now. This idea is on my mind for
> quite some time, but never had time to do it. Maybe this gives me motivation to
> do so.
> 
> Niklas: Did you get a chance to look into this? Else, let me know. I'll take a
> stab at it.

I just remember talking to you how we would want such a callback to work,
but unfortunately I haven't had any time to look into this.

(I guess too many other things with higher prio.)

Feel free to CC me on patches, and I will do my best to test :)


Kind regards,
Niklas

