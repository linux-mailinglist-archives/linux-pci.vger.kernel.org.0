Return-Path: <linux-pci+bounces-34110-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D05B28190
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 16:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A13E1D03E51
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 14:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C9221C9ED;
	Fri, 15 Aug 2025 14:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQz0qflA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E92321C16E;
	Fri, 15 Aug 2025 14:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755267782; cv=none; b=Y6KCMnmV3z7aC8sNk/kcbf/nR1GRifRgfuSbgwW1+LjOQuET5e78wu6ZUxl3hwMwPQ36kzMDUhR8H1EZwYXO0dPDPD2mBNj2BiPvIdhlmRLuI44zSxTNYYQ5EJYD9gN8JihErCn6fvlsXj5vTSbSr6tGDTaP5ySfN+Rgg8/sxXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755267782; c=relaxed/simple;
	bh=pA72tSZ0MvRZhPFqZswVy3id+67WfOj9Us119elURao=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=M1Z60o5i8YqvHy3SOl3HGzLJ25cFeGkQUASCLYt1GC1NXRzFagWSkEKbH7yOMfjIPaYKFkdpPMzHGhyUh7mKL0v/Gp0wpVnEH6CefgycVfZmyae3zr9Gx3mLttGoi1KKTFDHqbTwzLySkAN5LL9JNSSA78Vf5Rj5uar83eOcBBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQz0qflA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD49BC4CEEB;
	Fri, 15 Aug 2025 14:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755267782;
	bh=pA72tSZ0MvRZhPFqZswVy3id+67WfOj9Us119elURao=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=aQz0qflA24dLjwdNsJ7x0Su++t+8kNiBV7Pjb4AySIAO6M4+fNyPhtiVW8Wbt1/BT
	 9OVDnj8Abu38x482aV8rvW7UR8HfAxfQoBNWjrCiz83KJV+EDtbYibuqQCYQ3F0sIc
	 0vRkD/aMjVdMLw4lHe2W4BLE8Kl73Wv6UYPqa48yGXk/vUvfX5tfqQhL8hCH9fzQVP
	 TXuZcYZ3dnQarvqSZNVSMHjRF7pQgMoNL57/M7g/xKvx1nycq5ggl7UupdIwlAYOxg
	 K9qaDWtZkQTN15eKlnAwOKdETtrQrchsD7nW4WjW1i3ljR97ThGW8dJ3FBYo4+1zUL
	 F/KCsHVtI+kTA==
Date: Fri, 15 Aug 2025 09:22:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "He, Rui" <Rui.He@windriver.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Chikhalkar, Prashant" <Prashant.Chikhalkar@windriver.com>,
	"Xiao, Jiguang" <Jiguang.Xiao@windriver.com>
Subject: Re: [PATCH 1/1] pci: Add subordinate check before pci_add_new_bus()
Message-ID: <20250815142258.GA377110@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DS4PPFD24E991EC6BCD98A674667D0D7AB39634A@DS4PPFD24E991EC.namprd11.prod.outlook.com>

On Fri, Aug 15, 2025 at 02:31:31AM +0000, He, Rui wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: 2025年8月15日 4:36
> > To: He, Rui <Rui.He@windriver.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>; linux-pci@vger.kernel.org;
> > linux-kernel@vger.kernel.org; Chikhalkar, Prashant
> > <Prashant.Chikhalkar@windriver.com>; Xiao, Jiguang
> > <Jiguang.Xiao@windriver.com>
> > Subject: Re: [PATCH 1/1] pci: Add subordinate check before
> > pci_add_new_bus()
> > 
> > CAUTION: This email comes from a non Wind River email account!
> > Do not click links or open attachments unless you recognize the sender and
> > know the content is safe.
> > 
> > On Thu, Aug 14, 2025 at 05:39:37PM +0800, Rui He wrote:
> > > For preconfigured PCI bridge, child bus created on the first scan.
> > > While for some reasons(e.g register mutation), the secondary, and
> > > subordiante register reset to 0 on the second scan, which caused to
> > > create PCI bus twice for the same PCI device.
> > 
> > I don't quite follow this.  Do you mean something is changing the
> > bridge configuration between the first and second scans?
> 
> I'm not sure what changed the bridge configuration, but the
> secondary and subordinate is indeed 0 on the second scan as [bus
> 0e-10] created for 0000:0b:01.0.
> 
> In my opinion, it might be an invalid communication or register
> mutation in PCI bridge.

> > > Following is the related log:
> > > [Wed May 28 20:38:36 CST 2025] pci 0000:0b:01.0: PCI bridge to [bus
> > > 0d] [Wed May 28 20:38:36 CST 2025] pci 0000:0b:05.0: bridge
> > > configuration invalid ([bus 00-00]), reconfiguring [Wed May 28
> > > 20:38:36 CST 2025] pci 0000:0b:01.0: PCI bridge to [bus 0e-10] [Wed
> > > May 28 20:38:36 CST 2025] pci 0000:0b:05.0: PCI bridge to [bus 0f-10]

> > > Here PCI device 000:0b:01.0 assigend to bus 0d and 0e.
> > 
> > It looks like the [bus 0f-10] range is assigned to both bridges
> > (0b:01.0 and 0b:05.0), which would definitely be a problem.
> > 
> > I'm surprised that we haven't tripped over this before, and I'm
> > curious about how we got here.  Can you set
> > CONFIG_DYNAMIC_DEBUG=y, boot with the dyndbg="file drivers/pci/*
> > +p" kernel parameter, and collect the complete dmesg log?
> 
> Sorry, as this is a individual issue, and cannot be reproduced, I
> cannot offer more detailed logs.

Do you have the complete dmesg log from this one time you saw the
problem?

As-is, I don't think there's quite enough here to move forward with
this.  I think we need some more detailed analysis to figure out how
this happens.

Bjorn

