Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5F7DFBD4
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2019 04:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730835AbfJVCkN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Oct 2019 22:40:13 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41146 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730867AbfJVCkN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Oct 2019 22:40:13 -0400
Received: by mail-qk1-f195.google.com with SMTP id p10so14869910qkg.8
        for <linux-pci@vger.kernel.org>; Mon, 21 Oct 2019 19:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SIowe0bvkHyBTDNYswHiN88YcAkwm5TEoGgNVc+ix4o=;
        b=yhS0mblUe4lpDgYbM0BYodLWFiF5NLD9Cxu2+enOIr1JMeSWrqM+cJHIPn8N22L9cB
         AbIcn3cuVt04kjm0tnB2WRcJfhrlrToE8vSO0E90jB8c+3DHVFqv+ORQg3KJKxUX4uZK
         bCZ308HjL0kKBBF7T36IDsDI358//mnD6bPLPAtVoYyceh0h0cXiCoh59mHTJQq4nTwF
         NrhKwrKl7NmdDDbcKPZBhCTVMzjln4MNfHxU5YJJ35QYHJjix/dZArIyE24Q/imiZkCh
         n4LuazaotEhmaOOo9FN2EJgjVaG/uFAC2NxZh5sv39z4u1V88Dk7Zm4C5gbgKUuK4Koi
         huDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SIowe0bvkHyBTDNYswHiN88YcAkwm5TEoGgNVc+ix4o=;
        b=Re67CVgsEpsGL4hJegQG1mYRk17y5d9iSyyOFI1t6jxDIvUlpVYJtu7BNyiaeLrcr2
         NUfmQl/PbSXxeaSAsI17uZ37VvmWY3YVqV/wqldjsbsj/cWYUI2LNUa8nuuPh+ONUzPE
         yf6R+q7SM9ePw8TpYsr2YiRWxZU1njWXQcD/sXL6Qc158ZbixCJMHIZXosdBk59M2uQa
         g8FlHsIunUmv0Wksa7IYsvQ+H82Ba+NwSN6DVKaA3GzTK38sxRidDJL6ixWaL8k1Ente
         Bz53FpHyQrBTCUYx4x9CEc22N1Cx3WvhQjC6DKrmB6I5CJVd6UShBdRQNkzwb6kUKYwF
         Vo/Q==
X-Gm-Message-State: APjAAAU6hBBibAqyM1PgQ0dn+Ax26cw7XyL4nblci1PmI4H6kcXpbFFD
        umQqZnpZymoVOumwn25HAyXGlmfVQ3e4PhsI7vlEYA==
X-Google-Smtp-Source: APXvYqyJqwIc2HQvSj7J7mTROit0ZAcQaeAa0civsjE+Zv3qI8E4qn47LBa4G2/EeuJ6QM+0Vj+WsxDzSknWbW7695A=
X-Received: by 2002:a37:71c7:: with SMTP id m190mr947918qkc.478.1571712011915;
 Mon, 21 Oct 2019 19:40:11 -0700 (PDT)
MIME-Version: 1.0
References: <20191014061355.29072-1-drake@endlessm.com> <20191014154322.GA190693@google.com>
 <CAD8Lp45hmYhrj9v-=7NKrG2YHmxZKFExDsHCL67hap+Y2iM-uw@mail.gmail.com> <20191021113353.GX2819@lahna.fi.intel.com>
In-Reply-To: <20191021113353.GX2819@lahna.fi.intel.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Tue, 22 Oct 2019 10:40:00 +0800
Message-ID: <CAD8Lp47dmOD0jRZC2Y_Q_Gqfy9X5zbPAoXFJ=2Dadq0W89EC=Q@mail.gmail.com>
Subject: Re: [PATCH] PCI: increase D3 delay for AMD Ryzen5/7 XHCI controllers
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 21, 2019 at 7:33 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> Just to be sure, did you try the patch or just looked at it? Because
> what the patch does is that it does the delay when the downstream/root
> port is resumed, not the xHCI itself.

I tried it, it didn't fix the problem.

Daniel
