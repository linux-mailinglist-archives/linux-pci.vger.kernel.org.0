Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCDE41F985
	for <lists+linux-pci@lfdr.de>; Sat,  2 Oct 2021 05:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbhJBDdg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Oct 2021 23:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhJBDdg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Oct 2021 23:33:36 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F20C061775;
        Fri,  1 Oct 2021 20:31:51 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id z11so13931481oih.1;
        Fri, 01 Oct 2021 20:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=VTgxhaMyHeOM/YH1orVTHGNy9BvH6IGGo8MbL/iSmeg=;
        b=k7BmG0cPdMxY59NPZggZ2R5Btk7R5a7KGMOFkiVLk35lpf4BjkMxNGlwiaR0n9p01p
         NScfuOmOoNjcNxfd885R9oTjTAhoWwPDbQ4Vh3tXQAqibLNTuD/aEMYCJcqe0HGGwn5Y
         gsamLSXdlzL8t9fwS6gAmLImR/DQMpJBu6YiSg+fIWVzEMZTwCiHRGTwQXz/PnGw0K4/
         Y/3yzwF/GA+eChK6r+Z4I4NOsWj+aSQRsbVvKv7Ymvy4yw2Z9rpUPyx68VDsWcCbiXd1
         T3npra1cXpjKSFN9BwMZTzS/VOwKxZhaxOQdX+3+xWVRVXtLWW/RfVHRCP4DebcJyLZp
         FRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=VTgxhaMyHeOM/YH1orVTHGNy9BvH6IGGo8MbL/iSmeg=;
        b=QOffvkPSYXP0eA6aBqRlDqCOnrROz5h4VngewtTvgNd/c3+Jy/7GerGabyF4vUb/bz
         4ql17izsiFpmdbpT7E7IchfDguMMIM+/ndEenP/odITTzKM7mQPpUZhuorecac6FEwwo
         HCdVKJ1+AM6jN3MVftGzptzsJ2JNw3ih8Q3/ptzsytoKfiAOyZB9/CILrhxm9O8IpWjr
         hCuHAovtafRbcxmE3Uc1rYXdcKMRM8ylHx2QB4XMH+sJGR2qDBGA5h4baMIBEItKEGKy
         H31hrw+6pfrhQv3zM5qqzy/YzjPnA09jpCha23PaAIOGbhGMnvwamWnBUPX6llWXIJ8Y
         s6Zg==
X-Gm-Message-State: AOAM530SstKJK2lIf1JiUkxzmb+d0RItSFYT3puObS46EtMGz0EZMmhr
        hmqcpAFFR4fXIV3KF2eFSxfS3afmkE5QdtISO5LJ4bPY
X-Google-Smtp-Source: ABdhPJzDiKfvnOOl76+W8SYotXZvr4z1LD2LbBbCnUGTAoGH0Pn7RLWBgBW2nGpg/LSVX5YmpnA0Zo5ru8lt+m6VGLg=
X-Received: by 2002:a05:6808:1912:: with SMTP id bf18mr6727020oib.118.1633145509797;
 Fri, 01 Oct 2021 20:31:49 -0700 (PDT)
MIME-Version: 1.0
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Sat, 2 Oct 2021 09:01:38 +0530
Message-ID: <CAHP4M8V6b-su=bpM-qMg5pnDKfvh-Ks_3bFfeK7p4hA2RqQw+Q@mail.gmail.com>
Subject: Recommended way to do kernel-development for static modules
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello All,

Let's say, I want to make a simple printk change to drivers/pci/bus.c,
compile it, load it, test it.

Now, since bus.o is built as a result of CONFIG_PCI=y in
drivers/pci/Makefile, so this module is statically built, and as a
result doing a "make M=drivers/pci" does-not-pick-up-the-change /
have-any-effect.

Doing a simple "make" takes too long, everytime for even a trivial change.


So, what is the recommended way to do kernel-development for static modules?


Will be grateful for pointers.


Thanks and Regards,
Ajay
