Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDE264FE80
	for <lists+linux-pci@lfdr.de>; Sun, 18 Dec 2022 11:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiLRK5J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 18 Dec 2022 05:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbiLRK5I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 18 Dec 2022 05:57:08 -0500
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F583A444
        for <linux-pci@vger.kernel.org>; Sun, 18 Dec 2022 02:57:06 -0800 (PST)
Received: by mail-pl1-f179.google.com with SMTP id t2so6465168ply.2
        for <linux-pci@vger.kernel.org>; Sun, 18 Dec 2022 02:57:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SR3ZBG9tCp4qWcOM332eV/1GvFXSiOBMj/N/Dx3y0FE=;
        b=M16SmRw59CuZDip4JfPVEAJEJr2XsZI3yDcfGtZG0T7O56K18VJJEsjV/Lg4YIlcPp
         3RWyLCgH6K5o2reMF/KHO5DW7OPmTzyaxYVaV++HAgsguculWJpovPfCrv2x69ENp+hE
         ZeX0PQEdwAGY1W4MqLEziQI+iUi7m2Te0nIAkEZIp4PXrM015GIRT87LaKLSAKeM4+Ww
         94/jzEbzYhjPxMiTQ4sPaGWQ4tLNbSD2NHi1aihxUEMNZ7qp7Ms9qILHIZQBC594mi97
         p6zbg5mSYIASOIlu/rbhRS6UiidWPPlkrtPntM7OKlzpcypX5AfkqvLuJKXcQR/3AJ9k
         R8NA==
X-Gm-Message-State: AFqh2kqul9WxxEZv6NUwIvIc1YhEKtQoxQBDAyyz0+bJRW+YxNwkPLDL
        2gnQywniGB7YOTHyZ6yNUO8DriDCXsg=
X-Google-Smtp-Source: AMrXdXtTZfoJ1wCLB1xEHlxKbQ9BsXvd7vuNb+TubhlwiaUjwFc+wFI4Tx7YrZKfXlOfdS6SG219Sw==
X-Received: by 2002:a17:902:7c89:b0:191:282:5d73 with SMTP id y9-20020a1709027c8900b0019102825d73mr8885438pll.46.1671361025746;
        Sun, 18 Dec 2022 02:57:05 -0800 (PST)
Received: from rocinante (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id e10-20020a17090301ca00b00189af02aba4sm4880218plh.3.2022.12.18.02.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 02:57:05 -0800 (PST)
Date:   Sun, 18 Dec 2022 19:57:02 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     "Alexey V. Vissarionov" <gremlin@altlinux.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jesse Barnes <jbarnes@virtuousgeek.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yu.zhao@intel.com>, linux-pci@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH] PCI/IOV: "virtfn4294967295\0" requires 17 bytes
Message-ID: <Y57x/iCSkdtU3kov@rocinante>
References: <20221218033347.23743-1-gremlin@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221218033347.23743-1-gremlin@altlinux.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

(CC Alex directly for visibility)

Hi Alexey,

Thank you for sending the patch over!  However, if possible, can you send
it as plain text without any multi-part MIME involved?  This is as per:

  https://www.kernel.org/doc/html/latest/process/submitting-patches.html

People have scripts to handle patches submissions, plus there is automation
that relies on e-mails being just plain text with inline patches.

Sorry for the trouble, and thank you for understanding.

> Although unlikely, the 'id' value may be as big as 4294967295
> (uint32_max) and "virtfn4294967295\0" would require 17 bytes
> instead of 16.

If possible, it would be nice to mention that this needed to make sure
that there is enough space to correctly NULL-terminate the ID string.

Thank you!

	Krzysztof
