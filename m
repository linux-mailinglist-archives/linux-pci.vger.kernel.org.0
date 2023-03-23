Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355E16C691A
	for <lists+linux-pci@lfdr.de>; Thu, 23 Mar 2023 14:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjCWNHM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Mar 2023 09:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbjCWNHL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Mar 2023 09:07:11 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC27E31E2F
        for <linux-pci@vger.kernel.org>; Thu, 23 Mar 2023 06:06:36 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id s67so7871096ybi.5
        for <linux-pci@vger.kernel.org>; Thu, 23 Mar 2023 06:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679576796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/r9LM1Q2qIKLtOPEl772hrltusDqn+Brh1BjZrpMNYM=;
        b=aJYOeYVIuVOFXyxuM0TlM1Dhy/T2DQixr0B3Lcf39cJnmKGZq5cUKA1v220YZuL/7X
         L/wO8MYy0AvL7CByAfTsZIQmnDogXfJSd9Zw/XA4dMQ3c2M2tSVHGqNpkB7ZZnjEfrvo
         yo86iXvQe9f8Ozn/TcO56lphPW2/hB+/tb/oX7g181MHJQEVQN14DC1CrxVbr7b+zM7i
         E5niJBI9NxeFlnU7cxR3JQ4Diu9njjF2yn77re5lpUWghhZgyf1jp8Vmqzi2LC8Or2QZ
         Syd2j5bd8NUzEkkNT57odPgmJuMeNLUFHvEzqVQm5kN18XDBzN3g2K5+9CZ4ae+yAUI8
         MHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679576796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/r9LM1Q2qIKLtOPEl772hrltusDqn+Brh1BjZrpMNYM=;
        b=CLXeTct0t6UOfa93vZygfDn5QC6uHwD6rA8HccL5eQwfF+3seSy95d6DYxa4mX5ycI
         qHlFGgFEDBu/72tJXwDYGswWEn9p26+Gy24bCa2+QNDaLPglLS7NvXrEFtapiOFX8pWR
         c+MxxpuU1nchQ8cw8YhsIJf81WZbkB+/Fa6ZrngoxtCsfCxukioCBRxtr1ynPw7F/Hk+
         XnjyI8d0/20+xyG2KNW4KUl1BiQnzsTcJae0kDeGc7T8rGd0VrTNyPdJBXFK9InSPria
         Nd9Nl+E9+vjAZZmi10ijZURa9cvoBYi0WDKBLX0KAbBsVu8G6jCc0gXsxMlCmsfsbJXF
         3dPQ==
X-Gm-Message-State: AAQBX9eDYYftfISbzpRlbEeg/uwxAzn+f3D3BVsiT9waElDaWx1WqnP7
        2B1ju/2izwAiN9jpyDryCknIRL/7FVUMPl4693+P52pOPSHyPI0z
X-Google-Smtp-Source: AKy350ZANGRUtGitxcZHoKtnsnguHi+xqg0awFuyXFXLKPcA/kC+NS7m8Mkqn0zmQpuTplN8mMcvMmxXLUCmeIVX+0s=
X-Received: by 2002:a05:6902:1005:b0:a6b:bc64:a0af with SMTP id
 w5-20020a056902100500b00a6bbc64a0afmr2287099ybt.4.1679576796025; Thu, 23 Mar
 2023 06:06:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230323090431.73526-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20230323090431.73526-1-yang.lee@linux.alibaba.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 23 Mar 2023 14:06:24 +0100
Message-ID: <CACRpkdZq8SBrqp3F7ViwrE=6yNLgHrA9RBngPD1GNyxRy5dnCA@mail.gmail.com>
Subject: Re: [PATCH -next] PCI: v3: Use devm_platform_get_and_ioremap_resource()
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 23, 2023 at 10:04=E2=80=AFAM Yang Li <yang.lee@linux.alibaba.co=
m> wrote:

> According to commit 890cc39a8799 ("drivers: provide
> devm_platform_get_and_ioremap_resource()"), convert
> platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
