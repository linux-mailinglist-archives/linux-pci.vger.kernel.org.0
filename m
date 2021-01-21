Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E553E2FF6DF
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jan 2021 22:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbhAUVL7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jan 2021 16:11:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:35210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727480AbhAUVLz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Jan 2021 16:11:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1A4C322BEF;
        Thu, 21 Jan 2021 21:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611263475;
        bh=xSraJc3Ojb8IlJmsggG0MHaKdh24ksZR+CxNhTNSDtk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=IfMpw2MfakqjImgKlCSr98Eo5hogORbULloQluV3dt8rt5hYbwdczj2CO8B86haKy
         sIjRBSafjwbvugY/G9HrMDJF0noi5H+5FyhEGokcOWoZAN1DYqLXLQ3ebO1EeoT9nz
         N2MxZkjgdxXAsVVGs1o+Q3h/lTVCwFSOMkZiPFfNvW6T5ai+5ntW2Gm6yrSXOLgGa4
         biejSJn5ubbhViR2VoqPYY6D5MvxnW3eTZkdg2eNXchSlkFgHcGJliG0Sp9qWmH5Pj
         +FTlobAFn1ndHN93aW+mDWfNgvx/5tkX+0ivENwgtuSO9npJc5j2G3feVAlPS4u7bc
         k6iAkl53ujAWQ==
Date:   Thu, 21 Jan 2021 15:11:13 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     srikanth.thokala@intel.com, bhelgaas@google.com,
        robh+dt@kernel.org, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        mgross@linux.intel.com, lakshmi.bai.raja.subramanian@intel.com,
        mallikarjunappa.sangannavar@intel.com
Subject: Re: [PATCH v6 2/2] PCI: keembay: Add support for Intel Keem Bay
Message-ID: <20210121211113.GA2691064@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YAnnALx/ZHJ+Euhq@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 21, 2021 at 10:41:36PM +0200, Andy Shevchenko wrote:
> On Thu, Jan 21, 2021 at 01:52:06PM -0600, Bjorn Helgaas wrote:
> > On Fri, Jan 22, 2021 at 08:56:10AM +0530, srikanth.thokala@intel.com wrote:
> > <checks MAINTAINERS> ... yep, all previous entries are in alphabetical
> > order.  This new one just got dropped at the end.
> > 
> > I feel like a broken record, but please, please, take a look at the
> > surrounding code/text/whatever, and MAKE YOUR NEW STUFF MATCH THE
> > EXISTING STYLE.  We want the whole thing to be reasonably consistent
> > so readers can make sense of it without being confused by the
> > idiosyncrasies of every contributor.
> 
> I guess even checkpatch.pl should complain about this these days.

Maybe so.  But paying attention to the surrounding content can prevent
a whole host of style problems that checkpatch.pl can't catch.

We call these changes "patches," but that's an unfortunate term.  It
suggests a band-aid, which is something very obvious.  If a Linux
change is done well, a reader should not be able to tell that it was
added later.  It should look like it was always there from the very
beginning.

Bjorn
