Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC1E010A7A5
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2019 01:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfK0ArC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Nov 2019 19:47:02 -0500
Received: from mail-io1-f44.google.com ([209.85.166.44]:42548 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbfK0ArC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Nov 2019 19:47:02 -0500
Received: by mail-io1-f44.google.com with SMTP id k13so22816148ioa.9
        for <linux-pci@vger.kernel.org>; Tue, 26 Nov 2019 16:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=83/lGrD6eJWQV6VIT4rmOn7nOn7G0mLwf/dy5oVQ0zA=;
        b=c0ZM2Z8HkpUwuiOX6woJPt+TV/odTwQS91POZ7XPy7zBMgY6BO+cMs+4IZW38Hlzf+
         eNWTef8ScOvYF3ODxL9SQYQkCl2aogeOjZSG6rVp31iH1kQsOKboXczikvAJoPSFbGS1
         sC05iq1n/xkP+TVDQeiPvf4Q5cQ5ndH5vot18/0Bj+9i5lFH6cyqxq90yw3C0YbH+NmC
         jFv+e//HcZ96zrvq0DxQEYF6ug3EEeVT0Rt0UVHv1HN+0RBlqtc7UZk8yKzxiQlJ7+3M
         OxTyV1i0UOIQgV4lXm0VANhV/xVNc6Bs714gAF+0cdd2D6qt6/9EG5WbOQwTSF1kwP9p
         +fBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=83/lGrD6eJWQV6VIT4rmOn7nOn7G0mLwf/dy5oVQ0zA=;
        b=GMFbK6v2/zy13boxU1gzX5QPVZNX0cQoPr7W05MRYVJHcrDAsyUYoipQZAMQeyuor8
         N4Y+M28WLuRlNk2uwbrO5VL2sd0RJmnRHW5OxjLK79hU3quEoNjqd3fDHAaXIY78ONmv
         eltuCZkiRJWwut7xFMqujwrBy1VOelmyiVqhi9X+zV+XpMJmKe0aLTFLm02wzhtANTca
         Yo50XGa0e/eyZSvH9FSe3uPS7UQQueGf46ZF7X4AhlYdCrIutCNk88ZcITpZNU9LsamG
         uSqPxDSgWchNRlhCWCVtC4QWH5Myrc0m/HtDjZ4/PZN1DL3QW0Hg4IQyB6fzGoKG9V7R
         I6mg==
X-Gm-Message-State: APjAAAUFO7+Le8pYLVccvtQmqPFwazajOFaGLSvwtDqQS2FCY9ZopnIt
        C6S1L2pC+Ww8Uu79Rr1OayPoWRVwmDK31Ziq3JMzRNmM
X-Google-Smtp-Source: APXvYqwMaw0Ntj2UXiVNmr3prvLMWXiCZv3bGTayKpqh0qmcGoPuYv5++j0TwDTfvxQO2rFr2xUT/c1NY11hVRBkCxo=
X-Received: by 2002:a02:3f10:: with SMTP id d16mr1619777jaa.139.1574815621388;
 Tue, 26 Nov 2019 16:47:01 -0800 (PST)
MIME-Version: 1.0
From:   Kexin Chen <kexinchen7@gmail.com>
Date:   Tue, 26 Nov 2019 16:46:25 -0800
Message-ID: <CAB5NJVdt3As=U5M-RRs-aQwVbAUeaXR8hj5+v=zw6EUePQkotQ@mail.gmail.com>
Subject: pci_bus_read_config constantly took 1.3 seconds
To:     linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

I'm Kexin. I'm working on Linux nvme system. Some of my test triggered
PCI AER uncorrectable errors leading to slow pci_bus_read_config_XXX,
which took 1.3 seconds for every access. This caused a lot of CPU
scheduling issues, for example, 'Thread not rescheduled for xxx ms
after irq xxx' or 'Softirq x took xxx ms', and finally kernel reboot
due to soft lockup. Definitely there's hardware issue, but could
kernel take some actions to avoid kernel from crashing and exit this
gracefully ? My current system is using 4.4.182.

Thanks,
Kexin
