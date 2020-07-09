Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB9F21998F
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jul 2020 09:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgGIHOh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jul 2020 03:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgGIHOh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jul 2020 03:14:37 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E05C061A0B
        for <linux-pci@vger.kernel.org>; Thu,  9 Jul 2020 00:14:37 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id y13so566744ybj.10
        for <linux-pci@vger.kernel.org>; Thu, 09 Jul 2020 00:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Fj/v4PW8m3FjORJS3am9NTBVhZTiI8fDbQ10eq/dOCI=;
        b=Djp5fBG7FPfnd9RMcc2ix+MlPlb+F+E1o5z2JkAs68kvUaHk67XEtx0zZ4fKiSS5F8
         5PbD/z/LiYECDjYV59Lm/j5qWAA0lv16hqJ4/07nKVglz2MrOPYzAGCof71uwohz2HF4
         KIt4ritoIR/kv96qQu+uWtz1VZq8W92WVUYsSkT8lRVNocGhnCCo61sR7fZ3gv6bKIDc
         dTe0Y7g9fbLYKg5bjQ+EZDBBinkjnVHDPAet1sp+MVbb/9y81Dqsi5nnBH2rsiqB/CxO
         r+UWdiUmMrDJnB9E0NjGHPgFHSvF9cvr8NSodnQhb0VgRqk/hCKuk6w/QsQakt2QtfgY
         Rs0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Fj/v4PW8m3FjORJS3am9NTBVhZTiI8fDbQ10eq/dOCI=;
        b=l65mXZQ27o35Mp1WLyfrB2YvVWSAndhHTFaiD/J+zMoAfUpWvq/mF3evSSiqmBNFHf
         o7pEFsHLNghfX1bdkR5wo6unoFR2kJqca2sbZX1AH8M0FXsFAJoMVS8lKm+tEAmfYXy/
         MhHVHAm+MSP7wHPVBmaNpmuY7bH/teLEC1myYfNzqT93Y5l9UFQAwokMkGg+3qv9N1nC
         mUCXWgMM6VsZPOf5K3+fe/fBsf8j0X9/ByvU0Aaxhjo0Ra3Caq4Cxnpek3uq1gEr9vHn
         Cd8K15j0od7kl/inOfjO8Z45KGiu11HfTnWlkWyVQhufyNWSwPYMdMDddWoG7FYgvHJh
         fHSA==
X-Gm-Message-State: AOAM533KDGAPbgLJpodJm5M6mtRfMf+FnGCNVFn/Wx0j4sb6U//UXmL4
        3KCh2eE5O43HPQePKZaYALRYcMBYeZ9nRw6yTf7neJMrzYY=
X-Google-Smtp-Source: ABdhPJz4bY4rEcCeR6wLtiystvhbj3eRiR0MipMW++aAAqKg9qBPy9Oyu2Rd8WrqXJwdvwbyKpT+3tQHjByEujr6iMQ=
X-Received: by 2002:a25:4c81:: with SMTP id z123mr9401448yba.433.1594278875512;
 Thu, 09 Jul 2020 00:14:35 -0700 (PDT)
MIME-Version: 1.0
From:   Manish Raturi <raturi.manish@gmail.com>
Date:   Thu, 9 Jul 2020 12:44:24 +0530
Message-ID: <CAHn-FMy0i=c6jj_yvtQXrKMU5T8F+2AUd79qUw7U98vs9U35hA@mail.gmail.com>
Subject: Dump of registers during endpoint link down
To:     linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Team,

I have a generic query , if an hotplug pcie endpoint connected to the
CPU root port shows link down, then from the debugging perspective
w.r.t PCIE what all register can be dump during the failure condition,
what I can think of is these registers from the root port side

1) Link status /control/capability
2) Slot status /control/capability
3) Lane error status registers.

Anything else we can dump which gives us more insight into the issue.
Also is there anything by which we can check from PCIE clock
perspective.

Thanks & Regards
Manish Raturi
