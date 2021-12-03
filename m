Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25DFB467C23
	for <lists+linux-pci@lfdr.de>; Fri,  3 Dec 2021 18:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239263AbhLCREe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Dec 2021 12:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240062AbhLCREe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Dec 2021 12:04:34 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99283C061353;
        Fri,  3 Dec 2021 09:01:10 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id n17-20020a9d64d1000000b00579cf677301so4068998otl.8;
        Fri, 03 Dec 2021 09:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=4pLxk7I16UyPlVEly608dE6yaANiOeOiDzOCIy8vIzw=;
        b=LJqxQ5gmqDmXZRVWGXjXcv8c8wLJeavWLuQiDkpKvGdA2p5B4HWuMHN7FO7bhuxeuY
         XyRw5fjcCGMDc/BZWLQSR2X6isokgZa0W2tN/Rihr50j3MEb6EIvOavkaYIyEJGoxjcU
         NjpC8ptVkkp2anyf4+sPulwLVg2+Rb3gSMD/B0LdFiebvE/qO6hOTh5Skzluo+vlUKcY
         G3SNo4rG5Dm4zbbznb7VrFB6YnX9tUnqqYGj0S3h+CfRyZf0FdkKQtuyzOwBSEwsWUME
         zDmuu7Va5hZs1MyU0YoySVS/GR9lzSyUEIWdYgFNu+cY5Ea6mgJqyxsKLxfajTMEqxBg
         CD+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=4pLxk7I16UyPlVEly608dE6yaANiOeOiDzOCIy8vIzw=;
        b=UA98MM+eVxLhUEGFF291HFEaqMxRxYqppqEW7ZPPL3BDkaJpeHPkjSxVdBYybUqZUA
         Wx12vrn9DIvP4BXjaS+PhIg0kcAGqeoAEJ7BYMAl7UNhK2gcBe8lrD4GiZXc2m1Q8Zdv
         pEvv1SSNoImSBXf2mwzyfnApgoap/4+yxlZhWwO0FVi7BMT1SLDfWXQ693W8pZaYPXtT
         c0/CM3n69YB/QalnTBGiuTCZtDJG+ktc7AKmiikR0BeYG+fDZTTRpGLYIZP4vTg317bx
         o0KtT+qtCEJFqnKH9OdeVQnD/uEGY5XmkKrf47CW/UQYjGk4x9JTheW80Bai/B946P6c
         X6ww==
X-Gm-Message-State: AOAM530ClhMG5XwtEsakSuOKD8TI+QU5lS5QyTWCP49Ba8zNBgtkLY1P
        LW66RYgSydiZYL7sE6HHoLQHQrqV80hK5qEG3wuYGZ01Hk8=
X-Google-Smtp-Source: ABdhPJw6hrdacJ62/3uuSmIXkCjCzl0C1Zw3yi2uUMB/pAe+QA6JvioigWOi4C3G4DUZuUvfRsZDsjQM86VN8uF8dVg=
X-Received: by 2002:a05:6830:30b7:: with SMTP id g23mr16995052ots.159.1638550869641;
 Fri, 03 Dec 2021 09:01:09 -0800 (PST)
MIME-Version: 1.0
From:   Subhashini Rao Beerisetty <subhashbeerisetty@gmail.com>
Date:   Fri, 3 Dec 2021 22:30:58 +0530
Message-ID: <CAPY=qRQJ-YbRi0AStrytsE3ke4vFN9K4Cos2T+b1JKDPJGUVOg@mail.gmail.com>
Subject: PCI: latency
To:     linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

 [ Please keep me in CC as I'm not subscribed to the list]

Hi all,

We are using the Linux OS on an x86_64 machine. I need to measure the
PCIe latency on my system, does kernel have any latency measurement
module for the PCIe bus?

Thanks,
