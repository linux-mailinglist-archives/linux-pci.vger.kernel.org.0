Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF3536B283
	for <lists+linux-pci@lfdr.de>; Mon, 26 Apr 2021 13:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbhDZLuP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Apr 2021 07:50:15 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:41724 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbhDZLuO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Apr 2021 07:50:14 -0400
Received: by mail-oi1-f176.google.com with SMTP id r186so28369596oif.8;
        Mon, 26 Apr 2021 04:49:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p9F86T9h7602Fl6+TzddeYKXK/1gVrIGGZyfmSG1Vys=;
        b=rocBFH0Voxw05QkB5MZ2+Xky9VIDX1u1p9TtuynPMHE2/2VXxeN9fffb93vQSxk/NN
         CMsvP+2qK7lTP31MUKaO0lOHd+s6o34fPWiaxBGPAdIjZiBRvv2QqJ1KG6DID62ZulIA
         HXQiJpJLid5526vZAfJtQ2c4IsacT1REU9ckRT9rjvpikhQ39dg47kptk+hm8bFYdod2
         IYeR3tJhcvbTrs0APOqZiDlTLWITu57N09lMCy7GmWhGc6HMIRxgNtivSH+voZO71OVr
         MvWHQue18ZRs+cMqgn2PwiD8XAEsZn2tl//yyL9v8iC3J7F9o6wisNP1MLPGjiSX0Iga
         g+QQ==
X-Gm-Message-State: AOAM530Gv7/U3GhTpX8aj1lt6pt9APKu5T7rdXknRZ5zdV5x4dLih0Ai
        oC7hwtDsO/aB20Tw8RiRz1Wa51EANIniLEz2pX7ePBuI
X-Google-Smtp-Source: ABdhPJx5GrUxGsRFl+KIvzoja/xec5WPmkW+zWyrx4LIdDd5Tsqd14K9KRuF2gYlrInb4Z/rfiXAnltwTjkg+C9MtLQ=
X-Received: by 2002:a54:4501:: with SMTP id l1mr13347861oil.157.1619437770174;
 Mon, 26 Apr 2021 04:49:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210424021631.1972022-1-rajatja@google.com> <20210424021631.1972022-2-rajatja@google.com>
 <d53c72949d81db9f092a9aecb49bf56b47727738.camel@suse.com>
In-Reply-To: <d53c72949d81db9f092a9aecb49bf56b47727738.camel@suse.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 26 Apr 2021 13:49:15 +0200
Message-ID: <CAJZ5v0iNrSFjhmTE8K-JrO07kJon3ikhatbg0Jg2hs+x-frDJg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pci: Support "removable" attribute for PCI devices
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Rajat Jain <rajatja@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Dmitry Torokhov <dtor@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 26, 2021 at 11:17 AM Oliver Neukum <oneukum@suse.com> wrote:
>
> Am Freitag, den 23.04.2021, 19:16 -0700 schrieb Rajat Jain:
> > Export the already available info, to the userspace via the
> > device core, so that userspace can implement whatever policies it
> > wants to, for external removable devices.
>
> Hi,
>
> is there a way to tell apart whether a device can undergo regular
> surprise removal?

PCI devices located under a removable parent can undergo surprise
removal.  The ones on a Thunderbolt chain too.

> Do we want that?

Do you mean surprise removal?  Yes, we do.
