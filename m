Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8223D2FBE4
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2019 15:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfE3NEJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 May 2019 09:04:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:34526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbfE3NEI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 May 2019 09:04:08 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14EC425945;
        Thu, 30 May 2019 13:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559221448;
        bh=k3Go0/VjoRePfOIkwYY5BwatXzbg2FsH2u8FcDlRKFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FhO5mVtSSmTcf9VNmJ7aR+BQE7/uJc2lpymo3nie3NH0Cs1EO13BbnIROZqR2OAi6
         pZv5R0G5PbCzF9k9VlnqrjMMtc9pRtHxVGzmlBlG67yssp04MQVS0tL5A+/Rhcsl5J
         92u2eBIAnTLY6DvjwAEH6/fbARJhYgFdxfG7WuMw=
Date:   Thu, 30 May 2019 08:04:07 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Changbin Du <changbin.du@gmail.com>, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab+samsung@kernel.org
Subject: Re: [PATCH v6 00/12] Include linux PCI docs into Sphinx TOC tree
Message-ID: <20190530130407.GJ28250@google.com>
References: <20190514144734.19760-1-changbin.du@gmail.com>
 <20190520061014.qtq6tc366pnnqcio@mail.google.com>
 <20190529163510.3dd4dc2d@lwn.net>
 <20190530030139.GI28250@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530030139.GI28250@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 29, 2019 at 10:01:39PM -0500, Bjorn Helgaas wrote:
> On Wed, May 29, 2019 at 04:35:10PM -0600, Jonathan Corbet wrote:
> > On Mon, 20 May 2019 06:10:15 +0000
> > Changbin Du <changbin.du@gmail.com> wrote:
> > 
> > > Bjorn and Jonathan,
> > > Could we consider to merge this serias now? Thanks.
> > 
> > Somewhat belatedly, but I think we could.  Bjorn, do you have a preference
> > for which tree this goes through?  I don't remember if we'd come to an
> > agreement on that or not, sorry...
> 
> Actually, let me at least take a look at these.  I noticed that
> renames caused some of the ACPI docs to end up with lines >80 columns,
> and I'd prefer to avoid that.  So maybe I'll take these after all if
> that's OK.

I applied these to pci/docs for v5.3, thanks!
