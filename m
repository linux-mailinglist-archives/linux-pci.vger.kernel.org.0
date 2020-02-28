Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C44317408C
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2020 20:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgB1Txb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Feb 2020 14:53:31 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:36851 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgB1Txb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Feb 2020 14:53:31 -0500
Received: by mail-il1-f194.google.com with SMTP id b15so3799416iln.3;
        Fri, 28 Feb 2020 11:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JnlDWErKF8mDRNyNgdnTvgmZkvu7Blf7Wpl9qNzdgKE=;
        b=fSBOEP1IAhrdav6hcqPPq6DsovnldH8jwg12SD/B8C6OOHJz2/tIMVB25bjlbjrCqm
         kY5za1kNR4E27ndHju64DGymndfnKxmsNfP1Ks1RfuKQraLKMRsZhm6pKatILJ5pY99h
         qGCsKYc6j4ViyP9VHzpHizkFQGModsCPXJ4AeLzesSqpdg76oXmrObKISA2BqQt5SahX
         rNGKqlHSZh87S059uHUFeBs8mFDBU+TE09Xku624wTmSYsFMciAfxSCcssPJGQ9i1LSX
         1mm08Ghj+WuhUf5kV0aevMw4X+1IPLcGvfgSE7hIc97SWKQDjb6V7VA015sI4CF4g8WL
         h0VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JnlDWErKF8mDRNyNgdnTvgmZkvu7Blf7Wpl9qNzdgKE=;
        b=ElUI56lsOnjwpQXeEWGMjjYhQJdP7HDEbBLy6+2KgjDMlYtMMeLuJWBr3l+9N9wLaQ
         xQXOF83mIHfyaJSsZjw1d/ZjZK2UMN2tGaTCCwtm5kjmPYzIzqLd3n7Y7geJZnFWACJj
         iP+ZA/GmuQuLqDkgoEZ4nUUkOv2we5G6/Sm5i1WKIt+LfvayHYmk7YK4wqfUHH45XXpm
         ESxPp0UUGujPbLCjArS+m00HVhrmU/PKCnhALv4NqEv3//4arul2+bL5ZWJEbY0y5su0
         rGy8iOURfBSDOn3IJy88sgiit8tYbiY+6MoSUIgbxZwiJCBLrcwTOtx3kEFAmushKASr
         n4zQ==
X-Gm-Message-State: APjAAAUWTe/eSfkqs/A35rEiX1KsZnA0L6meKrbiUHk+hWnO2Lwo15Fw
        vdqHkN4SDiL/PBuhvexlQ/crY1/vnOyNvUxp1NM=
X-Google-Smtp-Source: APXvYqxXZ0r2eo6M1S+emYmrQwIWztg8xMvfzYm/JgHMlZSn4ba0L7GEsp02PDYFz4ehlz+b/mjNPY/05Tab1srb1iE=
X-Received: by 2002:a92:8c4b:: with SMTP id o72mr6223898ild.81.1582919610579;
 Fri, 28 Feb 2020 11:53:30 -0800 (PST)
MIME-Version: 1.0
References: <20191225192118.283637-1-kasong@redhat.com> <20200222165631.GA213225@google.com>
 <CACPcB9dv1YPhRmyWvtdt2U4g=XXU7dK4bV4HB1dvCVMTpPFdzA@mail.gmail.com>
In-Reply-To: <CACPcB9dv1YPhRmyWvtdt2U4g=XXU7dK4bV4HB1dvCVMTpPFdzA@mail.gmail.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Fri, 28 Feb 2020 11:53:19 -0800
Message-ID: <CABeXuvqm1iUGt1GWC9eujuoaACdPiZ2X=3LjKJ5JXKZcXD_z_g@mail.gmail.com>
Subject: Re: [RFC PATCH] PCI, kdump: Clear bus master bit upon shutdown in
 kdump kernel
To:     Kairui Song <kasong@redhat.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Khalid Aziz <khalid@gonehiking.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, kexec@lists.infradead.org,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Baoquan He <bhe@redhat.com>, Randy Wright <rwright@hpe.com>,
        Dave Young <dyoung@redhat.com>,
        Myron Stowe <myron.stowe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I think the quirk clearing BME might not solve all the problems, since
endpoint devices can sometimes not honor BME settings.

Better solution to me seems like not letting devices that we cannot
identify send us interrupts. I was working on a patch for this. I'm on
vacation for a couple of weeks and can post an update after I test out
my patch internally.

-Deepa
