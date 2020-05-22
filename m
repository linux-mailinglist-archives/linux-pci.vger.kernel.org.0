Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE971DECEC
	for <lists+linux-pci@lfdr.de>; Fri, 22 May 2020 18:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730528AbgEVQLW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 May 2020 12:11:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:43144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730534AbgEVQLW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 May 2020 12:11:22 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5112520756;
        Fri, 22 May 2020 16:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590163881;
        bh=0JTmKNCOSVfFXsp/l6r6vK0A1aX62Wnt1tZs/rKDZpY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=anRopDlSy27Vri+GchbA7goiaVkxcLQzgTGILyAL2Y3RvkT5TtlBC7txjMwEYL6j7
         XTGXoWBzRR7Aalhez7WPQA9Skc44AlXum58TyP+6N6k3pksrurLP+rSsrIRRZw5T6e
         6izbOEHyZyXCnZ4Rmk5yWEfz84A5oy/Qv/baUiVE=
Received: by mail-ot1-f44.google.com with SMTP id d7so8613586ote.6;
        Fri, 22 May 2020 09:11:21 -0700 (PDT)
X-Gm-Message-State: AOAM532k5UsPAP40VoevnSouJirLWONZSKcU0RR+ItZoco7PQHrGXGfc
        1t4fXEmfNwx9h5JxkCfGcCmhuYHHl5dhzigjfg==
X-Google-Smtp-Source: ABdhPJyquhMrY30oX4gcFNMGczIxMx6fthKgRqhOMu6BhGxOOW96NQ9jbvSWH8PRVc5mb4SegKMvgChoFfZrDVUK/ys=
X-Received: by 2002:a9d:51ca:: with SMTP id d10mr5587167oth.129.1590163880607;
 Fri, 22 May 2020 09:11:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200514145927.17555-1-kishon@ti.com>
In-Reply-To: <20200514145927.17555-1-kishon@ti.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 22 May 2020 10:11:09 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKxe5FtZfiQKcQFFLOM5F52kx-q8vZspPTXhcWg+3rJvQ@mail.gmail.com>
Message-ID: <CAL_JsqKxe5FtZfiQKcQFFLOM5F52kx-q8vZspPTXhcWg+3rJvQ@mail.gmail.com>
Subject: Re: [PATCH 00/19] Implement NTB Controller using multiple PCI EP
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        PCI <linux-pci@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-ntb@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 14, 2020 at 8:59 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> This series is about implementing SW defined NTB using
> multiple endpoint instances. This series has been tested using
> 2 endpoint instances in J7 connected to two DRA7 boards. However there
> is nothing platform specific for the NTB functionality.
>
> This was presented in Linux Plumbers Conference. The presentation
> can be found @ [1]

I'd like to know why putting this into DT is better than configfs.
Does it solve some problem? Doing things in userspace is so much
easier and more flexible than modifying and updating a DT.

I don't really think the PCI endpoint stuff is mature enough to be
putting into DT either.

Rob
