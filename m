Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0119454842
	for <lists+linux-pci@lfdr.de>; Wed, 17 Nov 2021 15:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbhKQOPY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Nov 2021 09:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbhKQOPX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Nov 2021 09:15:23 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484C3C061570;
        Wed, 17 Nov 2021 06:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=20OrWhq7ShdPRxUZdRVpu6ZrLfh0oU9gKnKyrbNbpDs=;
        t=1637158345; x=1638367945; b=VE0t7WuIpo9ea0+huvCZYlnb0p3Vks+I9T+KRZq4VmF6ljf
        qUSwBWu9RepTgHYba7XUyRxMPc0yL1umYX8hchvga5pmv+N4NjhJHhqmVvL8RDGeHo1WzraO46qXq
        V98snoBBuE2fW182S6yz27yYkEAYvSB6Jm1dXATqyEu1HsQM4sRSshz0l/VUVOdgVs8J5Kct6BeoO
        LwYGkjnZalZ9khwvhIK3XQStsM/2ubTeU6CEfHVeL8mVvlg4re+lZWFmcrafyBVamdyStrCDtqaZ3
        980+vGrOJIQkQUwNZzsCPdm9PocxWqaJJNiH52H3GDBEK8lLfmbl7fe4ZLYVa0TQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mnLfe-00GXu4-Mh;
        Wed, 17 Nov 2021 15:12:18 +0100
Message-ID: <5331e942ff28bb191d62bb403b03ceb7d750856c.camel@sipsolutions.net>
Subject: Re: [PATCH v2] PCI: Reinstate "PCI: Coalesce host bridge contiguous
 apertures"
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>, bhelgaas@google.com
Cc:     Guenter Roeck <linux@roeck-us.net>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Wed, 17 Nov 2021 15:12:17 +0100
In-Reply-To: <20210713125007.1260304-1-kai.heng.feng@canonical.com>
References: <20210713075726.1232938-1-kai.heng.feng@canonical.com>
         <20210713125007.1260304-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi!

So this patch landed now ... :)

> +	/* Coalesce contiguous windows */
> +	resource_list_for_each_entry_safe(window, n, &resources) {
> +		if (list_is_last(&window->node, &resources))
> +			break;
> +
> +		next = list_next_entry(window, node);
> +		offset = window->offset;
> +		res = window->res;
> +		next_offset = next->offset;
> +		next_res = next->res;
> +
> +		if (res->flags != next_res->flags || offset != next_offset)
> +			continue;
> +
> +		if (res->end + 1 == next_res->start) {
> +			next_res->start = res->start;
> +			res->flags = res->start = res->end = 0;
> +		}
> +	}
> 

Maybe this was already a problem before - but I had a stupid thing in
arch/um/drivers/virt-pci.c (busn_resource has start == end == 0), and
your changes here caused that resource to be dropped off the list.

Now this wouldn't be a problem, but we add it using pci_add_resource()
and then that does a memory allocation, but you don't free it here? I'm
not sure it'd even be safe to free it here and I'll just set
busn_resource to have end==1 instead (it's all kind of virtual).

But I still wanted to ask if this might be a problem here for others.

johannes
