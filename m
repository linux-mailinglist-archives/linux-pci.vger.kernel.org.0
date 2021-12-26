Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D955847F945
	for <lists+linux-pci@lfdr.de>; Sun, 26 Dec 2021 23:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbhLZWUf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 Dec 2021 17:20:35 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52256 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234715AbhLZWUc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 26 Dec 2021 17:20:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F1A9B80DE2
        for <linux-pci@vger.kernel.org>; Sun, 26 Dec 2021 22:20:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E41FC36AE9;
        Sun, 26 Dec 2021 22:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640557230;
        bh=3+67tQTPFrmNKkfjV3zVZt8wNcGBOg2R9H5h+6fyuMs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KANB1aJ1TA3zRm6IyjGsKi6L5d0b8VhMtuN4Crsqr/zHIhTnNAzeROmyrneG2gTN0
         VH6t0SQUFmHMC2snJJWxpcE3XAd+3t28Sv/I83rG6pxFSi2F9AaTz0dZvhcMW3aT19
         7oK7Zolg/YOyqGiPv8ii2cfbATtVmxfK+5vNyOseITFs7iSGECR0wjDfR4o2429VAv
         juLqQ6qBAz/utmUbyveP1yvgGOdPqZ/7yQoDV2NG9kTKFkJNf1PuymN6rH8hbqsV3p
         pUc0HwTypsUu7uoau85ZmwP5x1z0ZdZ0ZElkCG0WrswFGCeno9yzZ9mua4U6kRLQKt
         aD7IJdx0nDTCA==
Received: by pali.im (Postfix)
        id E5B9F9D0; Sun, 26 Dec 2021 23:20:27 +0100 (CET)
Date:   Sun, 26 Dec 2021 23:20:27 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH pciutils 3/4] libpci: Add support for filling bridge
 resources
Message-ID: <20211226222027.byugwn7c23ckwach@pali>
References: <20211220155448.1233-1-pali@kernel.org>
 <20211220155448.1233-3-pali@kernel.org>
 <mj+md-20211226.221209.62509.albireo@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mj+md-20211226.221209.62509.albireo@ucw.cz>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sunday 26 December 2021 23:13:11 Martin Mareš wrote:
> Hi!
> 
> > +      else if (i < 7+6+4)
> > +        {
> > +          /*
> > +           * If kernel was compiled without CONFIG_PCI_IOV option then after
> > +           * the ROM line for configured bridge device (that which had set
> > +           * subordinary bus number to non-zero value) are four additional lines
> > +           * which describe resources behind bridge. For PCI-to-PCI bridges they
> > +           * are: IO, MEM, PREFMEM and empty. For CardBus bridges they are: IO0,
> > +           * IO1, MEM0 and MEM1. For unconfigured bridges and other devices
> > +           * there is no additional line after the ROM line. If kernel was
> > +           * compiled with CONFIG_PCI_IOV option then after the ROM line and
> > +           * before the first bridge resource line are six additional lines
> > +           * which describe IOV resources. Read all remaining lines in resource
> > +           * file and based on the number of remaining lines (0, 4, 6, 10) parse
> > +           * resources behind bridge.
> > +           */
> > +          lines[i-7].flags = flags;
> > +          lines[i-7].base_addr = start;
> > +          lines[i-7].size = size;
> > +        }
> > +    }
> > +  if (i == 7+4 || i == 7+6+4)
> 
> This looks crazy: is there any other way how to tell what the bridge entries mean?
> Checking the number of entries looks very brittle.

I do not know any other way. Just for reference, here is a link to the
function resource_show() and DEVICE_COUNT_RESOURCE enum:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/pci-sysfs.c?h=v5.15#n136
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/pci.h?h=v5.15#n94
