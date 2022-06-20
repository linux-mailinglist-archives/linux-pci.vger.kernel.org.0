Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50D65526B9
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jun 2022 23:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238710AbiFTVvc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Jun 2022 17:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343884AbiFTVv3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jun 2022 17:51:29 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417961A3B6
        for <linux-pci@vger.kernel.org>; Mon, 20 Jun 2022 14:51:28 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id pk21so521821ejb.2
        for <linux-pci@vger.kernel.org>; Mon, 20 Jun 2022 14:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=l2XD/lnGb6wqP5beCOn5WCviv+KlTriN0tPq9p0OZx0=;
        b=qKAU+YBXOv3MslHoiBVSN+hLLLlZVOnaNXxmYBpwP0DC4Z6+ajlI+91A8yTVMCBZYO
         k5IrA3pICcWkEejVj6/ALcoOpE7bn9CUtpwQ8nqzKB5Y4EyljbZjB4g1ietjQwsfFEsG
         U2HCsI0HIbTYL/eq65PtlgY+xxGsQRboOgCVSFnaZLKfY1+a7S4X+9yLlS1F4occAZrC
         EazdqpyVcAfyxAJ7SeszCkRMbB24qKlmegl8QEcBmA/WbI7ADJ+r+KvPAYn/6IvXsoWw
         qK75QiUVEeHSrmhADPOcWEW0DLYZ1wO0Tf/fPiXtlFGAp++SVjoKwdw27jHnovoJqUDC
         e+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=l2XD/lnGb6wqP5beCOn5WCviv+KlTriN0tPq9p0OZx0=;
        b=EOMB2mUzIceE7W/ogConArQShUT5eUSifEE2sWL2+7bybp7F24ohkZBXhms7Vfrvlt
         6/eDr9iGyHmGg/j8hyNqvFo6gdd2gS+IaB0OS/7eXgA3uu4T0woNoV8YT84GFvIwWhrk
         BVPVCIl3RB/g5CNXd7wWOyyyqb06Tkd09Ptl5JtINH2/rRTUcaAF7Va9C9COfFFp425x
         s7CFLROozx3BzKZeMZvV1igbVulZwjIx0Pcn3W9Zi+ikg/NQXSLhjKvM4pbzelsngiwW
         sSIZPF7gtb7/sIracTdvQblA1oiUg+BcjT1aEdSeOC3jxRUFyLbqeRl2Z+UaQJJDCK6T
         /BrA==
X-Gm-Message-State: AJIora+7u52IXRi7b3yULdUJbkUWo0Ci8MM8VSM43kVqTj6ZNsEBwr5V
        bNRMpCqfoxhfbCJYXuRY7rRuKvJgD1v/WT23Y0o=
X-Google-Smtp-Source: AGRyM1u2X68PnK7zuQQfexK1L4ydDOof4JOYXtxMn+xMXD5LciE7onJn6N8tWvQU/GcxGHWdIjqyzncVJz9VJIrAWzc=
X-Received: by 2002:a17:907:72ce:b0:722:e1a5:164c with SMTP id
 du14-20020a17090772ce00b00722e1a5164cmr1026030ejc.111.1655761886803; Mon, 20
 Jun 2022 14:51:26 -0700 (PDT)
MIME-Version: 1.0
Sender: rev.fr.konephilip@gmail.com
Received: by 2002:a17:906:e0d4:0:0:0:0 with HTTP; Mon, 20 Jun 2022 14:51:26
 -0700 (PDT)
From:   John Kodjo <johnkodjo30@gmail.com>
Date:   Mon, 20 Jun 2022 23:51:26 +0200
X-Google-Sender-Auth: AxkwOPYNP5fNqVouGEMqWXcPRDc
Message-ID: <CAC+MiXnBd79QWg6nPRZVevAGk+HdZUfctCeGL7f__ZOgqFdxig@mail.gmail.com>
Subject: hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Good day, Please did you received my message?
