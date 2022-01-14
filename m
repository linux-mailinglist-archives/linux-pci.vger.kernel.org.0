Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F93748F2D2
	for <lists+linux-pci@lfdr.de>; Sat, 15 Jan 2022 00:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiANXGc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jan 2022 18:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiANXGb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jan 2022 18:06:31 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3081EC061574
        for <linux-pci@vger.kernel.org>; Fri, 14 Jan 2022 15:06:31 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id f8so3923227pgf.8
        for <linux-pci@vger.kernel.org>; Fri, 14 Jan 2022 15:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ZM/IMc2TG88+NJRFRr1Onz5HGFcIDkU3Ru1AwYyee6A=;
        b=h+eSAkCJcHYgfV9zd/uyWZYr8gicMf7oTBjqn3cGNMdCt7pSCB2eE6/JZ8qSOy8KE4
         HijwmTy/JAS3H4h6VYryrcCVlpmsk2+nQ+u/sFWI4oMmgejmNbVLGt0hQQqtWGlGsP4s
         vHZmb1W/H1A98cefPP3t6QjKE/Gf10vwCbArXxmeBMkua+ajQI+Lfh07fm72Fwjg9n0Q
         blhwq5fuun//qEm+LZP1B2od3xDk3G9EIyAw7ECYQYlCqgg5Lh4RxYt362BDsbqSip/X
         C9C8WadPdJtO+BK8i42QqrmfYepM2iEO0dEyZFG7sWqr9hEUlQZK6O+FuRu2RrV3GiBc
         WSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=ZM/IMc2TG88+NJRFRr1Onz5HGFcIDkU3Ru1AwYyee6A=;
        b=VcBvyqZjyQaAL58ij9Q2IsHMluGadLSUClTMxliaQfbRS3z89Qc2nheR7YKfPlL/fV
         plgMqBjUbA+ynhto9EHXIUsWouQ4zQVDhv3sLo33sU+H+PPaCjyqxpUo9ylfmSnUAzKo
         cEbJeSn7vP/yU1/ORD21A7iNJuTUM81p63ezyb4mE1IjiGCQ+FUuidCZ9KmS+z4azkl7
         nQpmbTMUOs6OO1+mOnPk2mDx50ge+SgXd/PhyO5XCu/i4jc5X0xVh2rIIe8wX54nX4el
         NpCNRGQeQfokj8xz5dLHJLZOcZQaFvxzjC2qloqMO8kTbWmUDjlaqNdxjSpRKx3NRGm7
         GXPw==
X-Gm-Message-State: AOAM5306o032nqh+2nXAL0bF2P4ThhpDTk/u7A3GiKZXVPawFY7rSE95
        /nKfcsrWdPzZlB/qcj9AWXJaR2oIRLEnH3Kbts8=
X-Google-Smtp-Source: ABdhPJzFvi8sVVNEbd6hxDj1oPkQhd0MaJqdi+nro3ALAXSz52LnDW3KmKvh9u1eQDt5VZwZMgC8NaHiCjxJOgcK1Pw=
X-Received: by 2002:a63:6e4f:: with SMTP id j76mr9782499pgc.76.1642201590729;
 Fri, 14 Jan 2022 15:06:30 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a10:fda0:0:0:0:0 with HTTP; Fri, 14 Jan 2022 15:06:30
 -0800 (PST)
Reply-To: fionahill.usa@outlook.com
From:   Fiona Hill <grace.desmond2021@gmail.com>
Date:   Fri, 14 Jan 2022 15:06:30 -0800
Message-ID: <CAOW9D1uiEszWuqd=g=psZb70OiAxyjm2Dq_g82uExZXVkMpwCg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

LS0gDQpYaW4gY2jDoG8sDQoNCkNow7pjIG3hu6tuZyBuxINtIG3hu5tpLiBMw6BtIMahbiBi4bqh
biBjw7Mgbmjhuq1uIMSRxrDhu6NjIHRpbiBuaOG6r24gY+G7p2EgdMO0aSB0w7RpIGfhu61pDQpj
aG8gYuG6oW4ga2jDtG5nPw0K
