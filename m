Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21AB03CF259
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jul 2021 05:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbhGTCZJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Jul 2021 22:25:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:51974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1376282AbhGSVZc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Jul 2021 17:25:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA44F6112D;
        Mon, 19 Jul 2021 22:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626732368;
        bh=jl3+HQaa6Y30qcgRRGvX0chBvuQ871X8ti+5rAJtfVc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=pcAfCBx+KzPds61fHhOS5ytEyCApu2DNAWHbdd7gwV9rYVp+OS0IDnM+F/BdTEAUg
         WiHG3xDNppY+cyw+5RVsebqh3ijs9YSwy1e+OjAHeOp8vkT/Z4TmSCK8nusUmD481d
         tj5vX/9dc4lZIKfz0sS1m9ZBFlazmy0h7e4kx7TTnA6pYBZKlaekf4nrEz+I1RhBRl
         sUxasixv/5Z/M7KF06AmL3FJfeoFBNdIF5EvTfdNl36SxTzUFmicxGVBUg8nGuEeiH
         envzF3EOdaznI9FX9ZpSWcO+4WVPs1YnHroqNhZIJG90OMLl8OpryqOVRKDLeMeNfZ
         bcse7kxNwyAlA==
Date:   Mon, 19 Jul 2021 17:06:06 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        marek.vasut@gmail.com, linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH V6] PCI: rcar: Add L1 link state fix into data abort hook
Message-ID: <20210719220606.GA30209@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210719172340.vvtnddbli2vgxndi@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 19, 2021 at 07:23:40PM +0200, Pali Rohár wrote:
> > On Sat, Jul 17, 2021 at 12:33:34PM -0500, Bjorn Helgaas wrote:

> > >   - "The R-Car PCIe controller is capable of handling L0s/L1 link
> > >     states."  AFAICT every PCIe device is required to handle L0 and L1
> > >     without software assistance.  So saying R-Car is "capable" puts a
> > >     better face on this than seems warranted.
> > > 
> > >     L0s doesn't seem relevant at all; at least it doesn't seem to play
> > >     a role in the patch.  There's no such thing as "returning to L0s"
> > >     as mentioned in the comment below; L0s is only reachable from L0.
> > >     Returns from L1 only go to L0 (PCIe r5.0, fig 5-1).
> 
> IIRC from L1 you can only go to Recovery. And from L0s you go to L0 or
> Recovery. But I do not know what is or was changed in PCIe r5.0.

Yes.  Per PCIe r5.0, fig 4-26, the LTSSM state diagram, that's still
the same.  The overview in Fig 5-1 doesn't include Recovery, Detect,
and othef LTSSM states.
