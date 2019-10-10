Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A95A8D31DC
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2019 22:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbfJJUQl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Oct 2019 16:16:41 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:35809 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfJJUQl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Oct 2019 16:16:41 -0400
Received: by mail-yb1-f193.google.com with SMTP id f4so2375760ybm.2
        for <linux-pci@vger.kernel.org>; Thu, 10 Oct 2019 13:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MLMwabB3+kykUPlj4jwFPRNN9g+7Qjcts+1oVZQGP5I=;
        b=eVz4uwN6L4dlHnUbeDQytnIklKCYBFfhG/Zy9JsZAQBI1p0jIq0WSUytwJJlVbxGRF
         XybqcC5miLvyo9M7y28N7S1cKDjsdlH8fHwHmEeQIvNKNYO6OuZMSHv/1nFAkhG8/aOP
         7/+p+wL1oHoUS9nTHTXESUqaddpYHvpM/sMhkGdgs/C9jpN/yuxybF5MT5Jza0sdMicO
         YlKgsAIoyoBuZwEkQoCccV4WE8jdMmvadeaHjqPL6w0E59TB8TIy5IRKqeDfwohYYB/n
         AzQokFhzDGo536XFMrcvWXPLXMYBv2q8Q/WVbJK7m/2L9OwIxXKlNR6zLgPto+YbWXs9
         u6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MLMwabB3+kykUPlj4jwFPRNN9g+7Qjcts+1oVZQGP5I=;
        b=FearjBCvSHgFtluUp6H5pTehNyOp1oS+8l5aPhnxyU8/Q97JQYibfYlkZj6AZR1/Ay
         CNCb+Qdm44ue6r4MgabdGY8aImyFLv27IQziiU/YZ7xnhtUX4UZcSLqdYrxPQy2qDNr6
         Xrd47j5gl1y7T81dowlmgqMT7DNcCLslU4jJGEHkQn3cWQn3S/NYldWBDnfdRFdhyvB3
         cDzcTmEefbMQslv1yXvaZyAOXr0MsnFCWaJdDIrYcTPq66+nKX2OvpHoYOR2xw8jLcbO
         /ZoYjnlxM2OB2w0S8bGtRnLX9cPMsXZtFRJPXK/e4BGTpo+cyqtOZ+N4Gc8CPAMmOReX
         64Tg==
X-Gm-Message-State: APjAAAXXTOslN0JKZabajA31hgaOWYPRwTRlpQOICAna6bUHfqpkrN3v
        CyOZNcvbf6SFe70Ec5xw0JmqvpxSXDOyQgYZT6w=
X-Google-Smtp-Source: APXvYqw45WqLwJrlA9w4vRZEoPfpmGaWyJjZCcGQsGhxt43neVBftJ2Br3H3WUvylDOh7nKkh+WLs6EaxXbtb3yU2fc=
X-Received: by 2002:a25:8309:: with SMTP id s9mr368139ybk.34.1570738600160;
 Thu, 10 Oct 2019 13:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <1569910334-5972-1-git-send-email-tyreld@linux.ibm.com>
 <1569910334-5972-3-git-send-email-tyreld@linux.ibm.com> <87y2xsifqc.fsf@linux.ibm.com>
In-Reply-To: <87y2xsifqc.fsf@linux.ibm.com>
From:   Carlo Pisani <carlojpisani@gmail.com>
Date:   Thu, 10 Oct 2019 22:16:30 +0200
Message-ID: <CA+QBN9Ae1aB-F0MBFF_5xWO=NLT9exG-2X+xS2RKXepKcHYRTg@mail.gmail.com>
Subject: powerpc/405GP, cuImage and PCI support
To:     linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Cc:     Tyrel Datwyler <tyreld@linux.ibm.com>, mpe@ellerman.id.au,
        bhelgaas@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

hi
I wrote here (1) a couple of years ago, I am still working with kernel
4.11.0 and there is broken support for initializing the PCI.

arch/powerpc/book/cuimage-walnut.c requires "/plb" compatible with
"fsl,pq2-localbus", while the device-tree file (walnut.dts) defines
"/plb" compatible with "ibm,plb3"

I am not an expert, but "fsl,pq2-localbus" != "ibm,plb3"

Therefore the PCI initialization of the PPC405GP seems wrong and every
kernel >= 2.6.26 is not able to correctly address the PDC20265

(1) https://bugzilla.kernel.org/show_bug.cgi?id=195933

an interesting not is:
kernel 2.6.26 can be compiled with arch=ppc and arch=powerpc

with arch=ppc the promise PDC20265 chip is correctly managed
with arch=powerpc the PDC20265 is not correctly managed


any idea? help? suggestion?

thanks
Carlo


--------------------------------------------------------------------------------------
    bus_node = finddevice("/plb");
    if (!bus_node)
    {
        notify_error(module, id, "device /plb not found");
        return;
    }
    if (!dt_is_compatible(bus_node, "fsl,pq2-localbus"))
    {
        notify_warn(module, id, "device fsl,pq2-localbus");
        notify_error(module, id, "device /plb is not compatible");
--------------------------------------------------------------------------------------
plb
        {
                /*
                 * Processor Local Bus (PLB)
                 */
                compatible = "ibm,plb3";
--------------------------------------------------------------------------------------


ide0 at 0x1f0-0x1f7,0x3f6 on irq 31
ide1 at 0x170-0x177,0x376 on irq 31
