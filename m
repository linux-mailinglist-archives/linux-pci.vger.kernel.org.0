Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7B2C11E9B1
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2019 19:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbfLMSEU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Dec 2019 13:04:20 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:43610 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfLMSEU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Dec 2019 13:04:20 -0500
Received: by mail-io1-f65.google.com with SMTP id s2so483747iog.10;
        Fri, 13 Dec 2019 10:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=jlzKVAxbx+/Wr5suXUGHs2MnNQmk3chg9M1fa3mxz0g=;
        b=Skh6QyHnf7xBMFDJYmzZZRHK0QvNMRhjfKNkFmERmWOjRUeuq9Cv8Dj3RgrxMNiTwI
         ywitD7tQC8mx+ruBvsmxhQHSZkSezs7LGvajniWTFxP+/GZ3n1IB+54WP1xHR+tn3aSb
         18zQItO6jGVSrwY0MzCcplQv9pZxuHfxzpfXFomF1dyHqb53kJfjOU7jUN0FvnB7utUZ
         2F6V1W5Q1cZ2UYl6trJVIsXy+0ZiShGux1TuA3q4IKdt8A0f67Jo2EWdqv3dpWUhIKOW
         4gVJ0tYkggMSUgNMeS2Qv3hCxmlslYR9tIzGISL7hi9nYeBLoWzU1I6TcEwsRGVrwt7V
         5hGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=jlzKVAxbx+/Wr5suXUGHs2MnNQmk3chg9M1fa3mxz0g=;
        b=W7OzOMfeV5+zRpiZjg8FJyX+KSi4qBmUgJj7svAE69dAhwFAajQhdy+mUxypmVTwn8
         4CAehv2AsTxpbN9NEdEdlvB2oFRz9w4/RDCMVXWZvnP+4VYMp3StwqO4MUV+D7pqygSj
         VTz4vfO02nVE8n9mNdOBt8hLny06cKZYmOUEMjnDS8amMBfpmO+5+F9sot8qKedpbEzY
         XKAUZqAkofjVEFpDPsvEoWuu2NyFqOdBDqHwFKaBayixDlYQ2/ndR1l03RKFkDs0GFt/
         nIFv1OhSJq7GShtPtaUko/SsdxbLcvX6oi9XQtJ5dJtFFMdz1/b7Cx9wu/oQHvjeXgH7
         xl+A==
X-Gm-Message-State: APjAAAVJbJxZ9hOoN1TyrV1l8xfV++s/pkSLBKFfKou3pPm9c7v2AKS3
        6IFFEv0njPZVqpiScwVoUqaAmF7t3AWNvXVCorGVCQHw
X-Google-Smtp-Source: APXvYqz+Ddjeu5WylBKH31KLJqL+in4RoPghN7qO8r+09q+bmZZr5Nz73OoWlxeyVxdUA4Ecm8R2x9ODEBCdv+gTVg4=
X-Received: by 2002:a5d:9512:: with SMTP id d18mr8473567iom.85.1576260259061;
 Fri, 13 Dec 2019 10:04:19 -0800 (PST)
MIME-Version: 1.0
References: <PSXP216MB043892C04178AB333F7AF08C80580@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <20191210213836.GA149297@google.com> <PSXP216MB0438B40D6EFFF5F9B5952F6580550@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <PSXP216MB0438B40D6EFFF5F9B5952F6580550@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Reply-To: bjorn@helgaas.com
From:   Bjorn Helgaas <bjorn.helgaas@gmail.com>
Date:   Fri, 13 Dec 2019 12:04:07 -0600
Message-ID: <CABhMZUU_6Ljn60sH_C8EwhKwF=uUrP2Y3ob1nnAM_UjM=i+8=A@mail.gmail.com>
Subject: Re: [PATCH v12 0/4] PCI: Patch series to improve Thunderbolt enumeration
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Logan Gunthorpe <logang@deltatee.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 12, 2019 at 4:23 AM Nicholas Johnson
<nicholas.johnson-opensource@outlook.com.au> wrote:
>
> On Tue, Dec 10, 2019 at 03:38:36PM -0600, Bjorn Helgaas wrote:
> > On Mon, Dec 09, 2019 at 12:59:29PM +0000, Nicholas Johnson wrote:
> > > Hi all,
> > >
> > > Since last time:
> > >     Reverse Christmas tree for a couple of variables
> > >
> > >     Changed while to whilst (sounds more formal, and so that
> > >     grepping for "while" only brings up code)
> > >
> > >     Made sure they still apply to latest Linux v5.5-rc1
> > >
> > > Kind regards,
> > > Nicholas
> > >
> > > Nicholas Johnson (4):
> > >   PCI: Consider alignment of hot-added bridges when distributing
> > >     available resources
> > >   PCI: In extend_bridge_window() change available to new_size
> > >   PCI: Change extend_bridge_window() to set resource size directly
> > >   PCI: Allow extend_bridge_window() to shrink resource if necessary
> > >
> > >  drivers/pci/setup-bus.c | 182 +++++++++++++++++++---------------------
> > >  1 file changed, 88 insertions(+), 94 deletions(-)
> >
> > Applied to pci/resource for v5.6, thanks!
> Thank you all for your time, support and patience with me. I have
> learned a lot in the past year.
>
> I will obviously stick around to address any potential concerns with the
> patches, but it also seems like kernel development is what I want to do
> as a career. Hopefully I can take this beyond a hobby despite my
> physical location. Perth, Western Australia is not big on this. Perhaps
> there are companies open to telecommuting employees. In any case, you
> will continue to see me around.

Thanks for your work.  Springfield, Missouri, is not big on kernel
development either, so I can sympathize with that :)
