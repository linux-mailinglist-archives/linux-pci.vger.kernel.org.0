Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01EB96EFC8D
	for <lists+linux-pci@lfdr.de>; Wed, 26 Apr 2023 23:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbjDZVgU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Apr 2023 17:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbjDZVgU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Apr 2023 17:36:20 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B57E76
        for <linux-pci@vger.kernel.org>; Wed, 26 Apr 2023 14:36:18 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-5ef5af7a761so11662876d6.0
        for <linux-pci@vger.kernel.org>; Wed, 26 Apr 2023 14:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682544978; x=1685136978;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XFXES0frkpdc522Sxe5fYzaDLq8r/TYBddPGjfRArvY=;
        b=X7mRUNxntmtk8d7BGn6s0ZJYJcBFX4xmKNYqk334DO4exvJFh1JslOFUIL8sa2v3cu
         9VT4Kvvnsk5jhWEBC8yxklm2qWM9EjeShbqnIk+/EL8usRZPdi/Qa1PPW95l9ebw6n8v
         TblO2Wac9IESy1r3JeAovs+11XKqWTX3rUMG4EN3Ssu4Ym6z0+Gudw+FFLAEC5AwZm0+
         qUnxSyY7DFiJKK6J46HgzKSZAHAC73IrjSY2hppANoagwO7avmu43HeHh1X0GqL1IxGR
         HXLkhAHH5cn0ycScPC6piI9onVOW+AOWYz4ChsIGxmfO+fC711yFVVAFogt0VFHLdfwT
         T83A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682544978; x=1685136978;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XFXES0frkpdc522Sxe5fYzaDLq8r/TYBddPGjfRArvY=;
        b=CB5hoZWuJT4O2McEu6g5HJpQ+2AHkrZJMjhhEJELo6lpd0B1OjulbsNr1gK9wi/Pmy
         sh4ESHCVMqqLJWCCVXWwezw5y7NrTwSmhx80Bjskd5U/vzTY+IorzYD9o40WarFKMzdd
         tsrGwHkhDZz7VSDheVTalBVlUpt0It5jo5Dqz4jeUsKZkjA79UfWbuoKH9iXCpu5gnPC
         EBvG78Y7C4+jbx2Nl6vezoYwnSAU3jEu2oSf5WqE9rIjMg01SWnSxCQv6WQoLNdTlAok
         o0x9jWETAjWzbs88iU9qqdpovysMNPC95yx35Hi4LEk7h96/yWEarsB6KfdykDRQDc/2
         1GLw==
X-Gm-Message-State: AC+VfDxF+hG5ScLX8ZupdeTqTA7AUiYmpG7VZ6nv2CtrsExeQvR9uXxA
        yXq2ZcTiDWFRquOEiLW91jBfUiRbqJSlALokaSI=
X-Google-Smtp-Source: ACHHUZ7/hpDmNuWYTWtQM9hjuuoRKEtR/+J8QDXpxah8RC/N5VWq4QFk7Nk60HkYMRdO2/c4o72jEhvaaAF5aeRnFhU=
X-Received: by 2002:a05:6214:3003:b0:5ac:463b:a992 with SMTP id
 ke3-20020a056214300300b005ac463ba992mr712204qvb.0.1682544978068; Wed, 26 Apr
 2023 14:36:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:dd0e:0:b0:5ef:7831:b011 with HTTP; Wed, 26 Apr 2023
 14:36:17 -0700 (PDT)
From:   Mark Klassou <jamesjanneth146@gmail.com>
Date:   Wed, 26 Apr 2023 21:36:17 +0000
Message-ID: <CAFYrV9FAiPXfoTQstzyv+aHw-g73DidbQgPSVB23wyCEenrxEA@mail.gmail.com>
Subject: Re
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Greeting...I want to know if you have receive my message i sent to you.

Thanks and God bless you.
Yours Mrs. Janneth James.
