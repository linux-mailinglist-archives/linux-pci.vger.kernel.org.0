Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69C291B7F5
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2019 16:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbfEMOSe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 May 2019 10:18:34 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44730 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728867AbfEMOSe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 May 2019 10:18:34 -0400
Received: by mail-pg1-f194.google.com with SMTP id z16so6845796pgv.11;
        Mon, 13 May 2019 07:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ketazh/cmP0KJ05p+l9m9holinNsc6KQfkPjwYogn7E=;
        b=k3SNBBhCPxo+UDPQbsBYMaWaplh2cwDY5+U+q/nacqm7DzhLPthqsb/t8BST7LMiq1
         ZpKc82ralzHV+mD2z9ukodEN1BZmAgxXlfsPSzzL4YMe7uYADPOkYGpUxbmHfpNybg03
         ef9EeKAYHaMPpoveKZvQbTPY3niVaeS5fJQMUnazxqZeAbLUJJjkUPl8gAPa0EUQqy6l
         aHRRX91mHxzdo/tI6qZvfR+yjx6J5YCURPo7E694nxBdeukeEroN0VBPcKryPpnH4AdB
         QEYlffk39un3Av14DPNyBe1QsufWwjRiAXYLHf29pZQq7DRS2PESDcHuOZUx+5thuTXR
         oEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ketazh/cmP0KJ05p+l9m9holinNsc6KQfkPjwYogn7E=;
        b=BIDqGi9+GI9DTXg0Lw4D4GZnwDyzvotkkdz0p8iwBW3F3dy7m7IKwIpZMKzku0yTIm
         r4e+VfdqPNpm1rAuwNgQwuarZa/jKPRZWqBQDgCySb9j+emjqF8wZOI5V79bqpzvowL+
         PYPuVmdA/RKsmf/TcMDmbuJfjMp2ow/CEywxXa3BVJcC/8QIc3J9P2uuWKB2n68Zewo7
         l+XOBNs1YAIzTccPZEKGOPHHJ7fPxeX9P5i86zTs9xfHMRIS86l7Wootb9IJEr8KdLg6
         U79sWcT82qkik9b8lVEk7N4xZVrvxh/Ss/sdnw2bxQjoqj5KbiGhlAepL38OwXFb3CwE
         SfRg==
X-Gm-Message-State: APjAAAUWRbYjbuOKhXsvKCI54RME0EF4CnukWsUHDHcH+1JhZIPJzOVP
        ET1Qeq7hO690oNHAQ3S60PVPl0Y5
X-Google-Smtp-Source: APXvYqxJy2oJO6PNfU4SFtZSqltP6F4ulJZxbMCpnn7tvwR0BgpaHB/qbGEqYt0DP//JCZhtJjGiug==
X-Received: by 2002:a63:e24c:: with SMTP id y12mr7185725pgj.276.1557757113391;
        Mon, 13 May 2019 07:18:33 -0700 (PDT)
Received: from mail.google.com ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id d15sm18241516pfr.179.2019.05.13.07.18.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 13 May 2019 07:18:32 -0700 (PDT)
Date:   Mon, 13 May 2019 22:18:25 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Changbin Du <changbin.du@gmail.com>, bhelgaas@google.com,
        corbet@lwn.net, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab+samsung@kernel.org
Subject: Re: [PATCH v4 07/12] Documentation: PCI: convert
 pci-error-recovery.txt to reST
Message-ID: <20190513141823.zaaq4aazpwe7egcd@mail.google.com>
References: <20190512125009.32079-1-changbin.du@gmail.com>
 <20190512125009.32079-8-changbin.du@gmail.com>
 <d00c1c42689e08df0ce7cd8b2c796eee5b9f5642.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d00c1c42689e08df0ce7cd8b2c796eee5b9f5642.camel@perches.com>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, May 12, 2019 at 07:22:13AM -0700, Joe Perches wrote:
> On Sun, 2019-05-12 at 20:50 +0800, Changbin Du wrote:
> > This converts the plain text documentation to reStructuredText format and
> > add it to Sphinx TOC tree. No essential content change.
> []
> > diff --git a/MAINTAINERS b/MAINTAINERS
> []
> > @@ -12100,7 +12100,7 @@ M:	Sam Bobroff <sbobroff@linux.ibm.com>
> >  M:	Oliver O'Halloran <oohall@gmail.com>
> >  L:	linuxppc-dev@lists.ozlabs.org
> >  S:	Supported
> > -F:	Documentation/PCI/pci-error-recovery.txt
> > +F:	Documentation/PCI/pci-error-recovery.rst
> >  F:	drivers/pci/pcie/aer.c
> >  F:	drivers/pci/pcie/dpc.c
> >  F:	drivers/pci/pcie/err.c
> 
> There is another section to update as well:
> 
> PCI ERROR RECOVERY
> M:	Linas Vepstas <linasvepstas@gmail.com>
> L:	linux-pci@vger.kernel.org
> S:	Supported
> F:	Documentation/PCI/pci-error-recovery.txt
> 
>
Will update it. Thanks!

-- 
Cheers,
Changbin Du
