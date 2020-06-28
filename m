Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACBA20C8FE
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jun 2020 18:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgF1QYE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 28 Jun 2020 12:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbgF1QYE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 28 Jun 2020 12:24:04 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A3DC03E979
        for <linux-pci@vger.kernel.org>; Sun, 28 Jun 2020 09:24:03 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id d13so7216695ybk.8
        for <linux-pci@vger.kernel.org>; Sun, 28 Jun 2020 09:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=WCYloJz+8lFWF4VSV0O5fa+C6Ch1mal/RPbSYB/y8d4=;
        b=X8RbfvH2Z3RcyC6FBj4bm0Z/eZPab8RWqHxdXUmfrDJelRItPX0VfU0j0B7dRR002m
         a6EuaES5DZIAsElT5Fbz8jj2pn3nT7AMYhyFgRGwUa0tK0aH/p9Hgvh6YFlbh7C3bSHq
         /oT1nIcredtZAMQx5dbAjm/dZHFLgTeIyaWyDw2JddDHf2tzQeWslPZuYj7GnhmBFPl4
         qmbYlcwzfQcQmzwlhcRmot0nTX13iNg3M5fYfdK0wLs1aU2WnXMDc3BFJLlK149b9udG
         1/9qtW2yeNExHRblx/PqDoeFmlHFDMszhLX8ZtuizucruahpGYWVI+36sSnqxGIOUHJu
         5Mig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=WCYloJz+8lFWF4VSV0O5fa+C6Ch1mal/RPbSYB/y8d4=;
        b=t/lIDNMmVKli9EZUXYG91tbi4NKBdMkb4hJ6rADoSLQaWaozL4Qb1a8PPji7Kuj4HK
         Xav/bByE3jku6Tj5SVWxUmSpESqCOoY0pP64Snp/AiKLfihVsaCC13lZ6mXZCfFyG2bB
         53rBHcJivvs3fzD3IJcsSmB3cNZcYk2KQg+dUKD4ATAqrWJ4Tr1V68NmsE6xbtkSEMRF
         W4+3y19Eam8AtNC9A+AyfHmsImsqOfO9RihKGHHw4H+YBTNAH2neCV9yNLu1cjSd/Tms
         gKHq/MbRn7BQzExrA+1z7Y4Iv4BXP7lmQZdiq00+F9XgkaAei5YoG3e+MZroQLFuAQbB
         VyYw==
X-Gm-Message-State: AOAM5301Ds7QsN3taNpz/aymzV0uXXdI+Jek4WE0VishoE8f1HY5p5cr
        MZWUf9w2V74b8Kg1KC1rrkTIbNrkK8ix6IBUwD+Z9fW0p6U=
X-Google-Smtp-Source: ABdhPJyV5OsiAG0THMZAJq2d3V1BOw8Y4LfY/GWue4I0E3SLLj/p8E2jSZrpNoftMe4B8Yi09pfUctvtOV2w822GVbI=
X-Received: by 2002:a25:e08d:: with SMTP id x135mr19609038ybg.482.1593361442343;
 Sun, 28 Jun 2020 09:24:02 -0700 (PDT)
MIME-Version: 1.0
From:   Manish Raturi <raturi.manish@gmail.com>
Date:   Sun, 28 Jun 2020 21:53:51 +0530
Message-ID: <CAHn-FMzcKbVY1H+bn+KKhO24QP1UpafEkj0PD_eCvnZWZ=fPSw@mail.gmail.com>
Subject: PCie Hot Plug query
To:     linux-pci@vger.kernel.org
Cc:     bhelgaas@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Team,

For the hot-plug , if we disable the "Power Control Present" bit in
slot capabilities register for the PCIE root port , then does it
impact any hotplug functionality?

Thanks & Regards
Manish Raturi
