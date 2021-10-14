Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D86042DDE7
	for <lists+linux-pci@lfdr.de>; Thu, 14 Oct 2021 17:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbhJNPS6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Oct 2021 11:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbhJNPS5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Oct 2021 11:18:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D8CC061570;
        Thu, 14 Oct 2021 08:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cseqrG4Z2/bDwbx2jL/k2noyTANUtsne2C2Mrg7jeaM=; b=aBjjSaD+khxohZsRlmtgHXs15e
        ushBAHQiSi2TjnxlWmWnV94/YvQsIXttvFmAQ1+uSUYv7AVI5wuD7Y5+QP9Q4NFkMZ+W3xuRnEGry
        2FOA03N3vKI0qidu/gVqKj+0r6BeFgDuiRfuB8lqrm49WiNeswejmeaFBYlkYDdkzy56WT4LlBq9z
        9pYRvR/1LPaNIH+VRRxvkugD3ecZE6CLMpNhkyeJfTFEbupMy4EHC5Xwk7nxXfIZloR84d5eooz+M
        1mXT25WjLfWU215GYLUWHZGy+uuMD38iz2KmLsKGD1z0RxTRZhFgSTFZ4BlLJAoQl+xkB13R+bAPA
        ZGlwP1Iw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mb2TK-003bqK-6T; Thu, 14 Oct 2021 15:16:42 +0000
Date:   Thu, 14 Oct 2021 08:16:42 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Benoit =?iso-8859-1?Q?Gr=E9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>
Subject: Re: [PATCH v3] x86/PCI: Ignore E820 reservations for bridge windows
 on newer systems
Message-ID: <YWhJ2kmGzNMVY+cP@infradead.org>
References: <20211014110357.17957-1-hdegoede@redhat.com>
 <YWgzaa9Z4elzoRwL@infradead.org>
 <40549939-e4c2-7b20-6bb6-0b5a46731b1c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40549939-e4c2-7b20-6bb6-0b5a46731b1c@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 14, 2021 at 05:15:02PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 10/14/21 3:40 PM, Christoph Hellwig wrote:
> > On Thu, Oct 14, 2021 at 01:03:57PM +0200, Hans de Goede wrote:
> >> +	 * Some BIOS-es contain a bug where they add addresses which map to system
> >> +	 * RAM in the PCI bridge memory window returned by the ACPI _CRS method,
> > 
> > Please avoid the overly long lines in your comments.
> 
> ?
> 
> These lines are easily within the new 100 char line-length-limit ?

That is an exceptional limit if exceeding 80 improves readability for
individual lines.

> And checkpatch also does not complain about this.

checkpatch has been completely broken for a while and should not be
relied on in any way.
