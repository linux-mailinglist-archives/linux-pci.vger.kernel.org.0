Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C30761CAAB
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2019 16:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbfENOpA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 May 2019 10:45:00 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35840 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfENOpA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 May 2019 10:45:00 -0400
Received: by mail-pg1-f195.google.com with SMTP id a3so8757449pgb.3;
        Tue, 14 May 2019 07:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M5gD5bOk+ivXRl6ir7PdHTTwAW2YSmsqQ0Eg23Ei5OU=;
        b=uFs9wWBU7EuqOsDKvz+cVP5WgvZBLERAglZL1D1EkqgHFgsJFcJNyXUC4W/qD+DUa3
         8wFk9QcPgy/7h0uKjPtKVTNXdaXwmBvISl6mRaVEvHW5ncRYa8bYA0efya5vogZZwjbv
         ZZRfTT3sEw+11xOiYQgrMVJGZTnGUAR9nA2Oo6SyWt/RcHjjZjVImXlPL1/GTCpYKl+7
         L4Y1bYP3a6NGTaOnfB2l0+o1sgCKRuDIpw0WMivnlUpPI75zzCsw/Lxv0C8FAiZSoJP1
         KNPUcCAFyCXlofgYR6a3aCUoUI0ptZW0NEwo1L4oFkfpkqQhM/wr56mneob9Q1UemtAG
         iDTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M5gD5bOk+ivXRl6ir7PdHTTwAW2YSmsqQ0Eg23Ei5OU=;
        b=ldN8rdtaLYyR4j8+pXLvpnPRXnvwVsgi2H01IHWYqbZy2XBMTFb+psjvPtNLYsy7vK
         uSSqyqdykp7JMLmlPPNVxa9yZR4QuWLbu3c9sVdUO6FEJLdujiiOj0fpLQ8ulroFdIml
         MEK9BGIjlBRzD2nZIL5Viq0cFOlE/KU8oP8P1frZDvnmk4owlTd/0PRfW/5K+KLVQqlQ
         8xb6Xa+PcKyJ3XU3593HXTgfL3ABi514ChWVDqMvOLceUdYi9AICsSroAaU3S125RwmJ
         VIWYn1PefmmCIw7meiK04eNAMHsOMmY8+ejyzWHDsGQOVCUDjqAydOVYOKOpTTVxuxg8
         ZMtQ==
X-Gm-Message-State: APjAAAVjWN/eCsfbGa2A4PtnOa0cwf2CzDeYzbV8o6/vxSKeIEMjLHwm
        JEnrX3dq7FMYCz3t9ZqhhsXNPecQBdM=
X-Google-Smtp-Source: APXvYqyszJva4EMMR5heKptgP1XLXDlVskpU1wnd/h+BaPS711IH58DJGKfAXnRBxzL0lGTgN6E4rg==
X-Received: by 2002:a63:465b:: with SMTP id v27mr38671882pgk.38.1557845099636;
        Tue, 14 May 2019 07:44:59 -0700 (PDT)
Received: from mail.google.com ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id u12sm2119425pfl.159.2019.05.14.07.44.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 14 May 2019 07:44:59 -0700 (PDT)
Date:   Tue, 14 May 2019 22:44:53 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Changbin Du <changbin.du@gmail.com>, bhelgaas@google.com,
        corbet@lwn.net, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 11/12] Documentation: PCI: convert
 endpoint/pci-test-function.txt to reST
Message-ID: <20190514144451.uxa4bkipmltllv5k@mail.google.com>
References: <20190513142000.3524-1-changbin.du@gmail.com>
 <20190513142000.3524-12-changbin.du@gmail.com>
 <20190513120423.159b971f@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513120423.159b971f@coco.lan>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 13, 2019 at 12:04:23PM -0300, Mauro Carvalho Chehab wrote:
> Em Mon, 13 May 2019 22:19:59 +0800
> Changbin Du <changbin.du@gmail.com> escreveu:
> 
> > This converts the plain text documentation to reStructuredText format and
> > add it to Sphinx TOC tree. No essential content change.
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  Documentation/PCI/endpoint/index.rst          |  1 +
> >  ...est-function.txt => pci-test-function.rst} | 34 ++++++++++++-------
> >  2 files changed, 22 insertions(+), 13 deletions(-)
> >  rename Documentation/PCI/endpoint/{pci-test-function.txt => pci-test-function.rst} (84%)
> > 
> > diff --git a/Documentation/PCI/endpoint/index.rst b/Documentation/PCI/endpoint/index.rst
> > index 3951de9f923c..b680a3fc4fec 100644
> > --- a/Documentation/PCI/endpoint/index.rst
> > +++ b/Documentation/PCI/endpoint/index.rst
> > @@ -9,3 +9,4 @@ PCI Endpoint Framework
> >  
> >     pci-endpoint
> >     pci-endpoint-cfs
> > +   pci-test-function
> > diff --git a/Documentation/PCI/endpoint/pci-test-function.txt b/Documentation/PCI/endpoint/pci-test-function.rst
> > similarity index 84%
> > rename from Documentation/PCI/endpoint/pci-test-function.txt
> > rename to Documentation/PCI/endpoint/pci-test-function.rst
> > index 5916f1f592bb..63148df97232 100644
> > --- a/Documentation/PCI/endpoint/pci-test-function.txt
> > +++ b/Documentation/PCI/endpoint/pci-test-function.rst
> > @@ -1,5 +1,10 @@
> > -				PCI TEST
> > -		    Kishon Vijay Abraham I <kishon@ti.com>
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=================
> > +PCI Test Function
> > +=================
> > +
> > +:Author: Kishon Vijay Abraham I <kishon@ti.com>
> >  
> >  Traditionally PCI RC has always been validated by using standard
> >  PCI cards like ethernet PCI cards or USB PCI cards or SATA PCI cards.
> > @@ -23,30 +28,31 @@ The PCI endpoint test device has the following registers:
> >  	8) PCI_ENDPOINT_TEST_IRQ_TYPE
> >  	9) PCI_ENDPOINT_TEST_IRQ_NUMBER
> >  
> > -*) PCI_ENDPOINT_TEST_MAGIC
> > +* PCI_ENDPOINT_TEST_MAGIC
> >  
> >  This register will be used to test BAR0. A known pattern will be written
> >  and read back from MAGIC register to verify BAR0.
> >  
> > -*) PCI_ENDPOINT_TEST_COMMAND:
> > +* PCI_ENDPOINT_TEST_COMMAND
> >  
> >  This register will be used by the host driver to indicate the function
> >  that the endpoint device must perform.
> >  
> > -Bitfield Description:
> > +Bitfield Description::
> > +
> >    Bit 0		: raise legacy IRQ
> >    Bit 1		: raise MSI IRQ
> >    Bit 2		: raise MSI-X IRQ
> >    Bit 3		: read command (read data from RC buffer)
> >    Bit 4		: write command (write data to RC buffer)
> > -  Bit 5		: copy command (copy data from one RC buffer to another
> > -		  RC buffer)
> > +  Bit 5		: copy command (copy data from one RC buffer to another RC buffer)
> 
> Why not use a table instead?
>
hmm, table looks better.
> >  
> > -*) PCI_ENDPOINT_TEST_STATUS
> > +* PCI_ENDPOINT_TEST_STATUS
> >  
> >  This register reflects the status of the PCI endpoint device.
> >  
> > -Bitfield Description:
> > +Bitfield Description::
> > +
> >    Bit 0		: read success
> >    Bit 1		: read fail
> >    Bit 2		: write success
> > @@ -57,31 +63,33 @@ Bitfield Description:
> >    Bit 7		: source address is invalid
> >    Bit 8		: destination address is invalid
> 
> Same here.
> 
> If you replace the two bitfield descriptions to table:
> 	Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> 
sure.

> >  
> > -*) PCI_ENDPOINT_TEST_SRC_ADDR
> > +* PCI_ENDPOINT_TEST_SRC_ADDR
> >  
> >  This register contains the source address (RC buffer address) for the
> >  COPY/READ command.
> >  
> > -*) PCI_ENDPOINT_TEST_DST_ADDR
> > +* PCI_ENDPOINT_TEST_DST_ADDR
> >  
> >  This register contains the destination address (RC buffer address) for
> >  the COPY/WRITE command.
> >  
> > -*) PCI_ENDPOINT_TEST_IRQ_TYPE
> > +* PCI_ENDPOINT_TEST_IRQ_TYPE
> >  
> >  This register contains the interrupt type (Legacy/MSI) triggered
> >  for the READ/WRITE/COPY and raise IRQ (Legacy/MSI) commands.
> >  
> >  Possible types:
> > +
> >   - Legacy	: 0
> >   - MSI		: 1
> >   - MSI-X	: 2
> >
Also take this as table.

> > -*) PCI_ENDPOINT_TEST_IRQ_NUMBER
> > +* PCI_ENDPOINT_TEST_IRQ_NUMBER
> >  
> >  This register contains the triggered ID interrupt.
> >  
> >  Admissible values:
> > +
> >   - Legacy	: 0
> >   - MSI		: [1 .. 32]
> >   - MSI-X	: [1 .. 2048]
> 
> 
> 
> Thanks,
> Mauro

-- 
Cheers,
Changbin Du
