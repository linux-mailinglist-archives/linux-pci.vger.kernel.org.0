Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F302B44EE
	for <lists+linux-pci@lfdr.de>; Mon, 16 Nov 2020 14:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgKPNp5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Nov 2020 08:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbgKPNp4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Nov 2020 08:45:56 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D55CC0613CF;
        Mon, 16 Nov 2020 05:45:56 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id 62so13255187pgg.12;
        Mon, 16 Nov 2020 05:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2xltnhArQ46zPt1AhUH7/HjKCFSGIMeJZ2ZE626Cb4k=;
        b=JrVsFEPbaP7qtjZTl0SaHhYi0aQajdxebrHZeCx+I/FBKSSY2cdWFUT3tAvbUPaLao
         AizGgOZ7y2IBjwQynHChCnwHKMe17K9/TnKK6KTiWEbfHb9U4pw+jdhJySRwEY3mtyqm
         PSIzz17l2ctPjTw1XlIAxyLMesds8eDW+VqUUaVAG0lZX/aIuhPa7lSz4UTzg79Wj5at
         24KWPPJM94hrIp5t2/NrviPa263GJyvvNf0qF9M4mYdn/nJSLhnb9MxGufkYNJMu9qeR
         tja+74BNb4s1G0ofn83Yb+6tw+SGm+OJqodGqo+C3Zm5FqBj0BMeCqba4wqqdHqcOEXj
         Ip8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2xltnhArQ46zPt1AhUH7/HjKCFSGIMeJZ2ZE626Cb4k=;
        b=mMFGwQRCOvoGe9mx1reyxo9/CAxOoF4cBLFmSnsSQtWtyMDR69qwwydJFEUb8HIoSD
         4AbObRgNzGN4aeR/bwiiGmxkuG9rPWkb0VF8I9JEaFu0OKPt3uhmyU8pZ8m9XV8tSMlw
         w5Hx/8/4gadIimhaBemipZTFTj59AFwA8OiIJdzjlFVO00CFaqqYyyewlWl3rSb9X4wN
         P64RpZD7s0iMP0LHoC6SCaTIco8Ls/r5cGNeWh2mA5/7Nq5CMCTXO32F0ItczKV20gkp
         ijKqUwh/6+0JRDKrciVS0ufXREjA3fHhm95Zojjdrb1ydUE09MdAWPtQl/BbDsexlUPj
         S8Xw==
X-Gm-Message-State: AOAM5326C9GDhjVM+RcUAMA10pC+o/JbxNusX2roGYf0H6PFUGBpKvs8
        +PO/kx+HWvVQ0VjMfufpwc7dcA8ciR/Yc2nqtwo=
X-Google-Smtp-Source: ABdhPJytXcRS+PUZHr+vY/FY2mP+eW3iwttP1o2/6RewHYJEWGUN2isHUzPIgRAsot9cE92t7RGb0n50eC0wENn9ag8=
X-Received: by 2002:a63:3e05:: with SMTP id l5mr12624254pga.74.1605534356088;
 Mon, 16 Nov 2020 05:45:56 -0800 (PST)
MIME-Version: 1.0
References: <20201116094644.GP4077@smile.fi.intel.com> <20201116123735.GA1273179@bjorn-Precision-5520>
In-Reply-To: <20201116123735.GA1273179@bjorn-Precision-5520>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 16 Nov 2020 15:46:44 +0200
Message-ID: <CAHp75VdYg+u5jhb9aA4w=f4WbqQLD8aUaf1MRCWp2c+CHOr67A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PCI: Disable MSI for Pericom PCIe-USB adapter
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>,
        USB <linux-usb@vger.kernel.org>, alberto.vignani@fastwebnet.it
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 16, 2020 at 2:42 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Mon, Nov 16, 2020 at 11:46:44AM +0200, Andy Shevchenko wrote:
> > On Fri, Nov 13, 2020 at 05:21:38PM -0600, Bjorn Helgaas wrote:
> > > On Fri, Nov 06, 2020 at 12:05:25PM +0200, Andy Shevchenko wrote:
> > > > Pericom PCIe-USB adapter advertises MSI, but documentation says
> > > > "The MSI Function is not implemented on this device." in the chapters
> > > > 7.3.27, 7.3.29-7.3.31.
> > > >
> > > > Fixes: 306c54d0edb6 ("usb: hcd: Try MSI interrupts on PCI devices")
> > > > Datasheet: https://www.diodes.com/assets/Datasheets/PI7C9X440SL.pdf
> > > > Reported-by: alberto.vignani@fastwebnet.it
> > >
> > > Is there a URL to a problem report we can include here?
> >
> > You mean URL to email archives or something else?
>
> Yes.  URL to lore email archive, bugzilla, or any other report of the
> problem this caused, i.e., how Alberto noticed something wrong.

Okay, I'll include in v3.

-- 
With Best Regards,
Andy Shevchenko
