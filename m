Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2209A2985A9
	for <lists+linux-pci@lfdr.de>; Mon, 26 Oct 2020 03:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1418775AbgJZCw0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 25 Oct 2020 22:52:26 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39112 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389281AbgJZCw0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 25 Oct 2020 22:52:26 -0400
Received: by mail-lj1-f193.google.com with SMTP id m16so8151328ljo.6;
        Sun, 25 Oct 2020 19:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AwSbvxKq0VAfO74U3k40Hd6ILxvYvhZQurF8b1QOMtA=;
        b=Q6AA36Q929Z1/5aYQTeDbm99kwaF6D1OcvZ9JKZRxjYGnfHCrXXWvBkby++magzUqv
         GEl065D4tjl7/GFM87ODyN8tutcTc/mKsfsgcArGgL11b+T6ifWn61Xdr434ras8+0od
         9I4uZQlwxjKDy/IRxqIz+TBqm1KVbUDZ6LAWqBzsIWjvhEau8Dposcc6gH+Sk5/edFFb
         428XtEcmxWLCWo6w3P+JN94Kw6LeNqN3j8Heg7zmofWOUUP33sQGubY78ioJT2EjVPtt
         1V++N5zAmvWie2NdhM0r08+r9gjtw13B3FRn5alh9xSOeD2r/xt4tDAQL8+FvzlFN/Nr
         to+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AwSbvxKq0VAfO74U3k40Hd6ILxvYvhZQurF8b1QOMtA=;
        b=cuicKS+F+6dvswBDc9HDUot3xebaC6EMUFN/BER6eQ+a2TPovy4b9szlbynCKiBMwj
         8A0o54XeXNgJ28Ln3olYEZ5LW/mA0Rw/sfkn6+f69IjbrEclAj59PW1b2fPAMT6eccuZ
         Hnb6SzzWuRntXpGg1ZkKlXKsWrg+88lCfm/IiWVN8J2loA9XHXck+JdbJ+r3Sv2EPK63
         tj3aE2W7+vsxrhRlHxgihGueXv2uFF3gpqRf8cjkWx+EIy1s5PfMHe/+IssFRWn6ueJt
         Zp3CphirOBD0ChzFssoBWTgJgrwbgG65wnlL1eSx0gnSujsUkn1biq+BIOpsouKYI2dB
         KhTg==
X-Gm-Message-State: AOAM532vp+z9GNOjF9A9GRjb07K69U2A/i+TcXiclOGmn1pWLC/ByLwI
        rFaol+7CoPti5P3O078cZjhQRw4LqDzgItCrSBU=
X-Google-Smtp-Source: ABdhPJzWLv5qnZGy1jWVg7VEnQ64QLKMqnf+uX4XGRqPB8+oExh3AcQl7oEJyBbj+ApCrryp2MMXeDhyVb6Ud7I5bNM=
X-Received: by 2002:a2e:b1c2:: with SMTP id e2mr5228295lja.282.1603680744355;
 Sun, 25 Oct 2020 19:52:24 -0700 (PDT)
MIME-Version: 1.0
References: <20201021081030.160-1-zhenzhong.duan@gmail.com> <20201022152148.GA23673@infradead.org>
In-Reply-To: <20201022152148.GA23673@infradead.org>
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
Date:   Mon, 26 Oct 2020 10:52:10 +0800
Message-ID: <CAFH1YnNQ5fL3TFQg_UqcFH6-fgmR8ZN9WkFUF9ZWNtb8k6zvvA@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: export pci_match_device()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 22, 2020 at 11:21 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Oct 21, 2020 at 04:10:29PM +0800, Zhenzhong Duan wrote:
> > pci_match_id() is deprecated as it doesn't catch any dynamic ids that
> > a driver might want to check for.
> >
> > Export pci_match_device() as a replacement which supports both dynamic
> > and static ids.
>
> You don't actually seems to add any user outside of the PCI core,
> so I think you only need to drop the static specifier and add a
> prototype.
Thanks for review, will do it. I'll combine the two patches into one
if no need to export.
