Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872F4707CD0
	for <lists+linux-pci@lfdr.de>; Thu, 18 May 2023 11:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjERJ2x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 May 2023 05:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjERJ2w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 May 2023 05:28:52 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7862133
        for <linux-pci@vger.kernel.org>; Thu, 18 May 2023 02:28:50 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-966400ee79aso340107266b.0
        for <linux-pci@vger.kernel.org>; Thu, 18 May 2023 02:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684402129; x=1686994129;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zYlqmqzmZQIzuckqyml+D+cUQfB/LAmhyfGQVjeCZAE=;
        b=gtnjKTyXOLSsKou+ZtT7Js3k0ABaZ2q/Vdv0ZoHT8Ndld7DDKF9uphJsozKbGnGUJj
         IkTSvev6rVN6QqyST/ZAU1gYqJaKESj2ZwV9Z3K7ekII6TsPWYBKnbEm5HOuRDVhcjfx
         8lL/heGhG0PytscwaOuqsFcY5tvez/3hpAsWjA0zrA4zqMaqaVOZVbaTfTrxKrhIrrKq
         MBwkLMqQtLovPfWBCrKe9fQT/+AhRH2WaPNEGb1piJBwYWEJAM2ftwojIK3QG6lcUIqy
         /aSVhL+FoUR3z5cw0q6x/wjG5lAVyOJFlO60iv4mr43N+SBZh91zl1EkD7cXkPaXW7mI
         Z9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684402129; x=1686994129;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zYlqmqzmZQIzuckqyml+D+cUQfB/LAmhyfGQVjeCZAE=;
        b=Z3gyKslOYwZLCc1c0rMcrMvkUTnALR7eR2gSJIlfcms94a/HmwsXMM0Vbz2CMbFg/q
         suKXSW7pRuYly8UGvZH3d0ENMMBDL4XfcPAkkjJ6b4UUUEBIgcSsr/w54e8Is94UzALs
         UAYhxzogGEYoEev1xuSQtFLys1RRyQROZkOkRO7iN7mvr/RbZRiRDoieUT9BzOhVVzgD
         DLScfhdGIKOgTTZAG959vG3AunCrgiy31z8f/hVOrQt16CoiXEzBNXN+p4UdTqS8pSvH
         faTvbbkNKeVJnbGA6rJ/pOml29DnWbgpcPcS/O7KPbZJDvlCltSx+DY/Dur9RBhQUu5s
         2/UQ==
X-Gm-Message-State: AC+VfDzP14AFqZCyzecQo/VybV5EX+DJWEfMozmpUEVw0zC/o8CejPjk
        n/feqFQ1h3mxIauj23qGGcEhq0wpbAME7n9xJYQ=
X-Google-Smtp-Source: ACHHUZ6JLscwQclVvra+JH6DMsgNjrn1UYPFDeRU8pBIIiAI1n2oIqURpqQB8ZWxOFbgZqjPHiObNACk6qnSQNiIH+Y=
X-Received: by 2002:a17:907:9347:b0:94f:322d:909c with SMTP id
 bv7-20020a170907934700b0094f322d909cmr36760051ejc.34.1684402128402; Thu, 18
 May 2023 02:28:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:906:dace:b0:94a:7e28:ef2d with HTTP; Thu, 18 May 2023
 02:28:47 -0700 (PDT)
Reply-To: ninacoulibaly03@myself.com
From:   nina coulibaly <ninacoulibaly013@gmail.com>
Date:   Thu, 18 May 2023 02:28:47 -0700
Message-ID: <CAHS6EwX4OfwndFTCJNwNVSd_qkh309YmPxpfxe4_FPHuA+u3OQ@mail.gmail.com>
Subject: from nina coulibaly
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Dear,

Please grant me permission to share a very crucial discussion with
you. I am looking forward to hearing from you at your earliest
convenience.

Mrs. Nina Coulibaly
