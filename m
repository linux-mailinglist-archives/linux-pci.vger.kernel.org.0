Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4BA4BDF70
	for <lists+linux-pci@lfdr.de>; Mon, 21 Feb 2022 18:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358988AbiBUNWj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Feb 2022 08:22:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358987AbiBUNWd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Feb 2022 08:22:33 -0500
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD52E2181A
        for <linux-pci@vger.kernel.org>; Mon, 21 Feb 2022 05:22:07 -0800 (PST)
Received: by mail-vk1-xa2c.google.com with SMTP id k128so8612941vkk.10
        for <linux-pci@vger.kernel.org>; Mon, 21 Feb 2022 05:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=94r73LrRNpO7YYFshzYM25uztFOXVTrm/QHuYFLiQ7w=;
        b=mADrFrQ+ZaM0TTq14DVXo+gL51+p2NcBjrN5ntCAKNfmsIAoFYM5Vg05TATz1Ho3Mp
         QntpqOZN3naiWGycPE6mYfwtwAPtneL7Rw/9nMeZB7wOOnN7+w2ZC1J+VfjucP6dvjgH
         lTknf1/DqWRCd1lnEY8XJSo0sGGNKAN/Q2AhiiVd+kM3VozUxI+7uzBPycoXp1Vaqj8M
         p4xbfkLFbWc6MBQeg7cIzVnUHjQm0cWUH2jqTe7+s4ph8qXwOHR43B1LSf5Ms39DYX6u
         tw+yyEkJLsVPXxfaTvunyjyvU9BKx7n8SvP6JAiSZnaM93bNVM1/BrqWWs2xeZURVai0
         iuLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=94r73LrRNpO7YYFshzYM25uztFOXVTrm/QHuYFLiQ7w=;
        b=OrvDQQ9DyK4Ng7nfPL+RjK6iPf8D/dGzrAH8f7ZjdOE1OEg9w2Ng1YdScgQQN/v4H/
         lZtvp0ul+Z3kLjfR/QlMu+Zl2n/JARgyGZp+DkDAIUss0T+80CtFMj94KjQqjbNUaSRW
         I5AhFfqZX8js0iJI/RXBjnlgV/YYj/0Qp+0OYpS/2c/OOIu4t0ue1YfJP+Aby/hNlGk+
         fanKagIAu+gAbskKYdrOOhL+0hQbH9wYcu4xRWLXReKh6KS1Lp9DlknBwca1qchj8TfL
         haxpKvh0JYuwQTcgu0WEzx0C7WVtJFFuHAVAfxd8Or9H9POq+QAqVQtiwMupFQFIw+x4
         Ptgg==
X-Gm-Message-State: AOAM530dwstfqL1mhxGpuLoVhrWJ74FPUAM80rRvYujuGuU8IXUP95/U
        IosCvzA4nmiQfzGpsdakuMXiuB65gITygLTnxJw=
X-Google-Smtp-Source: ABdhPJzY3uRVFinJaUL83lROLKmjYUZ+TZRkDI5fVeFEVDRnDD4++VfHZ1wYicaoN9REPkmsXvaggGijHkcU6zzfCJU=
X-Received: by 2002:a05:6122:c9f:b0:330:e2ed:4786 with SMTP id
 ba31-20020a0561220c9f00b00330e2ed4786mr7735605vkb.29.1645449726641; Mon, 21
 Feb 2022 05:22:06 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a59:d8cd:0:b0:28c:6bb4:8918 with HTTP; Mon, 21 Feb 2022
 05:22:06 -0800 (PST)
From:   Anders Pedersen <ousmanebarkissou@gmail.com>
Date:   Mon, 21 Feb 2022 13:22:06 +0000
Message-ID: <CAE0fZ3d1A2trQ_6K_TKOtuh1imki0Bk2BNv+2OWiPjRVVrO41A@mail.gmail.com>
Subject: Hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Greeting, I'm Anders Pedersen, from Norway. I want to know if this
email is valid? Thanks.
