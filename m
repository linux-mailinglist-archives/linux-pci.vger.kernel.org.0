Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4A7A42CD36
	for <lists+linux-pci@lfdr.de>; Thu, 14 Oct 2021 00:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhJMWFW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Oct 2021 18:05:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:38688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229821AbhJMWFV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Oct 2021 18:05:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5CF0610CE;
        Wed, 13 Oct 2021 22:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634162597;
        bh=e6Vbm4yp7xvXhw5QyTAzwWmSLUWIUDk7Gr5Hr+bJzP4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F5BTdUjF5GBsZXf6TNFcyUlmumdcwehRsYioroL1Q2VLZVmVzg2lGK/4Unpsu8Je/
         ycKw1VPw9OZyygtXpI70bnJnkB8ZhtyuJoLLmol/K5u/DgFWr6BG4n4YZUnsu3dCRf
         LS1Kzwvd9isv4FuapMLd3xudWfaaYe1BUzaKwZKiBZMD+EourUt3uFCtSXxSI1K1DC
         Xa2nCBLHxOEZzwhdg5YqrPva2rOShkNoq3INIXTB+bCagCwuhbhSGIEJ475ZSdrlMB
         WHvDw9nVQ072C/erA6LjEwEDzHo2YN1q4h32arbRpMpbsrgxQwdYU8PYsH2y/AwvLk
         XU7z58zGuPnaA==
Received: by pali.im (Postfix)
        id 023C97FF; Thu, 14 Oct 2021 00:03:14 +0200 (CEST)
Date:   Thu, 14 Oct 2021 00:03:14 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/22] PCI: Unify PCI error response checking
Message-ID: <20211013220314.pz3dzskd23axkdg4@pali>
References: <YWS1QtNJh7vPCftH@robh.at.kernel.org>
 <20211013024355.GA1865721@bhelgaas>
 <CAL_JsqLobP9MM0EFnof_nDOBrox=gKH3xe3EQbqPceq8pRRgyA@mail.gmail.com>
 <20211013171653.zx4sxdzhvy2ujytd@theprophet>
 <CAL_JsqL0d4qOR+wsnpdRUc+EQ6_diUzPbMj3Tv-Ly29or6Asvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqL0d4qOR+wsnpdRUc+EQ6_diUzPbMj3Tv-Ly29or6Asvw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 13 October 2021 16:47:43 Rob Herring wrote:
> On Wed, Oct 13, 2021 at 12:17 PM Naveen Naidu <naveennaidu479@gmail.com> wrote:
> > The thread does bring up a good point, about not returning any error
> > values in pci_read_config_*() and converting the function definition to
> > something like
> >
> >   void pci_read_config_word(struct pci_dev *dev, int where, u16 *val)
> >
> > The reason stated in the thread was that, the error values returned from
> > these functions are either ignored or are not used properly. And
> > whenever an error occurs, the error value ~0 is anyway stored in val, we
> > could use that to test errors.
> 
> Presumably, there could be some register somewhere where all 1s is
> valid? So I think we need the error values.

I guess that "Prefetchable Base/Limit Upper 32 Bits" PCI registers can
contains all-ones value and it is valid value in these registers.

And also PCIe regs like "Slot Capabilities Register" can also have all
bits set.

So 0xffffffff does not mean that error happened. It is needed some
application logic which can decide based on other things (like register
number, device state, etc...) if 0xffffffff indicates error or not.

Therefore return errno values can help, but only for controllers which
provide this additional errno information.

> Also, I seem to recall only the vendor/device IDs are defined to be
> all 1s for non-existent devices. Other errors are undefined?

In PCIe spec for vendor id register is mentioned that 0xffff indicates
no Function is present.
