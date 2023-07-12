Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868B3750CD6
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jul 2023 17:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbjGLPmf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jul 2023 11:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbjGLPmf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jul 2023 11:42:35 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A061BB;
        Wed, 12 Jul 2023 08:42:34 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fb7589b187so11570613e87.1;
        Wed, 12 Jul 2023 08:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689176552; x=1691768552;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rlyvltT+TDsU8aorJ6katMKTRoqeM7opfaR5ApThWtM=;
        b=EFG/VXUjRh4UrfnXYu5nGLwTrAls9lAdWj9WRQqTaVgmLqFpPlijetLYty46AciUYk
         +TYOOi+CjPTCHHO4ZwWVYXuV2yeO6VUh4rkdrQNvxtakVJe6EaLYYDYjHGePsmTfPOry
         WZu+vKUi7ltZIXAld1oH5gheeh8b88JZTWoocV8gZmP7yZYuwj7lLOrwmBIphlN8MrVy
         xlXbBizjbziObo7MLM/LIpXM3/4ynnHOXBnyFIx0SRUjjphP7OBUCdfiaeFvIixpvuLR
         yWc84RGUWZkNqHbJ6p9Fh6S0+zHtmfecql8xJoJPhlA7PknbRXJ8etErJ6z54eeUEUZg
         yTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689176552; x=1691768552;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rlyvltT+TDsU8aorJ6katMKTRoqeM7opfaR5ApThWtM=;
        b=dOhG92SnURDrxjS9KnPJ+ULvJ4KL+4V6ph9yMppqWpY7CqmJuXGb1F9LC4L7mC1zNK
         O4z+uNaNFEO5yJjJ/iMbkJYWEywYOcSkG3JJy6599FUnTIdM2JahAKfXgMa8PvNcvI/2
         c91vCQebLTG1DJJSiN2d5itE12Uk1TXkL5HAYbqUfeffy5VfaryjGbFHF6qRkWzBT8rP
         1G79et7hQRwmh0Y+IYg93a8xocGg3uF+UWY/F3CRO4ktbTRrKktTwjueFUTrTT6U+CFo
         l4tw9+VdcQGkHX5sYFaFF/kJFr94SS0/aBTfZ8FVQ1YOE1p4JSHPhkesGzkYo29kU/O1
         O+9Q==
X-Gm-Message-State: ABy/qLb3M6rv+fzqvp4dbR4fbrkvGvj0BP4lD9YmevwIt77ehdJiGozI
        3kVRC9B/0HoUZuXJv5Eu9mY=
X-Google-Smtp-Source: APBJJlFh1bdUChwGl7U4vHb1mdJrD+m6UPFPwDryvpr/QaFR5P9DcyKjGaB1u39/J2BwE2Bo+5XyMQ==
X-Received: by 2002:ac2:4f0a:0:b0:4fb:7be5:7404 with SMTP id k10-20020ac24f0a000000b004fb7be57404mr18891991lfr.63.1689176552020;
        Wed, 12 Jul 2023 08:42:32 -0700 (PDT)
Received: from localhost ([165.231.178.23])
        by smtp.gmail.com with ESMTPSA id d11-20020ac241cb000000b004fbc6a8ad08sm756979lfi.306.2023.07.12.08.42.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 08:42:31 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 12 Jul 2023 17:42:27 +0200
Message-Id: <CU0B41A94HS4.32OC49OW4W5SW@vincent-arch>
Cc:     <kw@linux.com>, <heiko@sntech.de>, <robh@kernel.org>,
        <linux-pci@vger.kernel.org>, <shawn.lin@rock-chips.com>,
        <linux-kernel@vger.kernel.org>, <lgirdwood@gmail.com>,
        <linux-rockchip@lists.infradead.org>, <broonie@kernel.org>,
        <bhelgaas@google.com>,
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        <lpieralisi@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        "Dan Johansen" <strit@manjaro.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>, <skhan@linuxfoundation.org>
Subject: Re: [PATCH v1] drivers: pci: introduce configurable delay for
 Rockchip PCIe bus scan
From:   "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
To:     "Peter Geis" <pgwipeout@gmail.com>,
        "Bjorn Helgaas" <helgaas@kernel.org>
X-Mailer: aerc 0.15.1
References: <CSK8M39MQL2C.3S7JO031H0BA2@vincent-arch>
 <ZF7m1npzLZmawT8Y@bhelgaas>
 <CAMdYzYqV72=pQa-U3a2N7MZ2ChBNL74QrxHQLbMZJxiftTK9sA@mail.gmail.com>
In-Reply-To: <CAMdYzYqV72=pQa-U3a2N7MZ2ChBNL74QrxHQLbMZJxiftTK9sA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all,

> Perhaps a hook mechanism that allows drivers to register with the
> serror handler and offer to handle specific errors before the generic
> code causes the system panic?

I have some time to work on it. I'm interested in exploring the=20
solution proposed here. However, I would appreciate some guidance=20
in understanding how to implement this type of hook to report the error.

Cheers.

Vincent.
