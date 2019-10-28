Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9487BE795E
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2019 20:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730328AbfJ1TuP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Oct 2019 15:50:15 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:34391 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730286AbfJ1TuP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Oct 2019 15:50:15 -0400
Received: by mail-yb1-f196.google.com with SMTP id m1so4516928ybm.1
        for <linux-pci@vger.kernel.org>; Mon, 28 Oct 2019 12:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xg6VwvniXMVgKduGCy26d7xbL2XznwZmMMdXdE2wcbI=;
        b=aa13CYKNnX6UxI+tz9SXS3sH3qdicKowHr0FX/nStC/j2BRep6mQfYhZuyled1yIyG
         wzgEGT0KshD+/oH+fFqWnkqYS7ng2m3TvE2zLvTgltzaUz7uNL4+3+jcAl5q9hcaWQiD
         wfALaZ1nmju5h6FOVOQmq4gncp9m+rWmJgLFVXuwBUJs/cj1CfpiusrFnwnjAy3cbA+5
         hpRQPaTIpQJySzhKEczY2hXgPR4O5B57279ziTXoCzPyK4YaTlDw7CM+fls2Aagt4J34
         ihzra7QbRZ8gzWSCiw/naUK/MoZSgTzchh+Ec49bZt2AWlXDJ+odZ3ruLIBm2dQx9TUl
         Z2sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xg6VwvniXMVgKduGCy26d7xbL2XznwZmMMdXdE2wcbI=;
        b=IatPajdX2wv9Wo8CgJ6s9nGSx8yINaYllLG88TXtUWmLYKA5bmFhHF0rZPFBQm0L8F
         ktOXwEDcUokBX7wAkbjhXXPrDinRU6sLw7F+7OvaOHw+eunFuN7ftXqILekoxQz/JQCe
         1j47gKkpSUUam4KOlzyU6/JwEt1GZurRtyKyKIS1X6tZdXOB+L/m8g8DGPSgerNZzQAz
         EzHtonu8tKXCqCYV7IJTt8nsxomhbACZD479ojeys/LI4EUdSBsZb9MXlyJLlFICquxD
         Iyf1FaRqB29Ra+Pn+4c2sp/zwS5+ho9flP6jvjQclLId6Gl9XSZDWpVWs1+TPS4p+k9m
         YQHw==
X-Gm-Message-State: APjAAAWIEYxE+FLHtkcSVN7SvyQkj9peCN/1tAatufKa0c510ug2lu4k
        3bWA+Q+S/+VGjMXrD+vH6kI6O5kGPdeHj9+OQ1U=
X-Google-Smtp-Source: APXvYqzxqUlDILk7CYJzg6hQG6u0By0n6/oTfVWsz3xc5dBQn3eOsvj5DMKgs0S24oM/YUoQAZpTmePT+O4dWzyWga8=
X-Received: by 2002:a5b:908:: with SMTP id a8mr3172674ybq.49.1572292214635;
 Mon, 28 Oct 2019 12:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <CA+QBN9C_o8HanAzXpDUN410g2o5+xfx64pbX3_VHVDKcj5N3kA@mail.gmail.com>
 <20191028171329.GA104845@google.com> <CA+QBN9DZyFynoUt+7sS_AcC-Wio-McJKCz8-RYfDWV0jv8iCzw@mail.gmail.com>
 <CABhMZUXADeHV+iUgFyDF+3BcQRFKDkMbwdkDAvBuYLd2XY=HCw@mail.gmail.com>
 <CA+QBN9Aj2he3RQMGaz21HD24gPk0R=bSX0cqVLj5PU4jK5Qrcg@mail.gmail.com> <CABhMZUWdeOQ_M0x8UwzmjGRj8Mrwfc49CqEdL_Tuejmrso8CAg@mail.gmail.com>
In-Reply-To: <CABhMZUWdeOQ_M0x8UwzmjGRj8Mrwfc49CqEdL_Tuejmrso8CAg@mail.gmail.com>
From:   Carlo Pisani <carlojpisani@gmail.com>
Date:   Mon, 28 Oct 2019 19:49:55 +0100
Message-ID: <CA+QBN9BigNZfAp0_h6WFpm6oSgBo3tiiN3S87hXZWsN_DNba8g@mail.gmail.com>
Subject: Re: Oxford Semiconductor Ltd OX16PCI954 - weird dmesg
To:     bjorn@helgaas.com
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> It looks like you're using a v4.4-based kernel, which is 3 1/2 years
> old.  In general people are not very interested in debugging kernels
> that old.  It's better if you can reproduce the problem on a current
> kernel, then backport the fix if you need it in an older kernel.

as specified in this topic (1), kernel >= v4.11 does not even boot on rb532.
When tftpboot, the firmware says "out of range", and hangs.


(1) http://www.downthebunker.com/reloaded/space/viewtopic.php?f=79&p=2755
