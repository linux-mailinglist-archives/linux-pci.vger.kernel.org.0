Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C905C6E71B6
	for <lists+linux-pci@lfdr.de>; Wed, 19 Apr 2023 05:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjDSDjw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Apr 2023 23:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjDSDjo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Apr 2023 23:39:44 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340DA40EC
        for <linux-pci@vger.kernel.org>; Tue, 18 Apr 2023 20:39:43 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-518d325b8a2so1083034a12.0
        for <linux-pci@vger.kernel.org>; Tue, 18 Apr 2023 20:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1681875582; x=1684467582;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a0e/blrL6Tf9C9Zm88s7yEUaau7+OiJEMt6DtUxmn8U=;
        b=heQMR9KeF4YP7cYFKebZxUoa0zwSm6yermCbrw1yWPuH8qOnanz2PICoK7wFsHoCii
         ITyyopfMMFdHPQ3l53RQJ9R0iCJNIqSOBu8v2kGorc56fgoHdo+lwQn7Rtyot6Fc2TRr
         edENA3S1GqNaFQoyAISXSMcD9w43pa2t9HmnVeof/RNZ8rjOMFaCqEAh77zgB8EAoQ6W
         kv4VzctHo6uh6MWOsPvjXLQbUvLQo6wLB2L4hbWjvmnu6qu8dtL4oR5XBt2/YOm2Avu/
         Hj08KoyiW66V1OPkWan8ZU06NlDH8ZrKHOh5SaFHvZXODbRYM1HW4zSJDCITBvWtjQwK
         dRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681875582; x=1684467582;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0e/blrL6Tf9C9Zm88s7yEUaau7+OiJEMt6DtUxmn8U=;
        b=QaBaw6lftjKl3yCdWlpTiO5HPqvAVhckD9CQnNsNaZs95zzK928taZT4ejrHwh4k2x
         rmup+gOSQ2CHMhrbV7qFYF4YPhhbcEFhDKKXmRYx1pjfNwCcmSBcxzOJjQ2uaFOBcV66
         a5FECCtrnG4Tb83YFzZRxcPdJg9xhjjomM//db9iroB412MEfaoz/nCvV8htkQJ114ct
         fct5ByOhFX1+3w210uVY+CsVUEaIUUS/CHpFVSM3JrABSwcuB7lC68uxELksQK0iGE2U
         e7SghEO/Rxtb7XU11xI4QeGkv1o1HAqExMtIfs7c9IhxycdPH8TBSzd1xIAd1DLaw/20
         fUMw==
X-Gm-Message-State: AAQBX9cKAk+05AqMwbEBpOnaajwqaE0cmxYCgQnueSJjfPQPqKtXKAMq
        icE37EQic5S2O7+nClTrpAxqYnBYFpaH/rA87c0=
X-Google-Smtp-Source: AKy350bVWhvudAUkLl/P0TT9j1GmLD1pufJBRjFi20EeKXYqEO3qjLGawXTfX3mlLaN9b1oPB/HNmA==
X-Received: by 2002:a05:6a00:2e94:b0:63b:89a2:d62d with SMTP id fd20-20020a056a002e9400b0063b89a2d62dmr2618037pfb.20.1681875582590;
        Tue, 18 Apr 2023 20:39:42 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id n9-20020aa79049000000b0062ddcad2cbesm10270224pfo.145.2023.04.18.20.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 20:39:42 -0700 (PDT)
Date:   Tue, 18 Apr 2023 20:39:42 -0700 (PDT)
X-Google-Original-Date: Tue, 18 Apr 2023 20:39:34 PDT (-0700)
Subject:     Re: [PATCH v1 3/4] soc: sifive: make SiFive's cache controller driver depend on ARCH_ symbols
In-Reply-To: <20230406-subdued-observer-cbb0e2f72cc7@spud>
CC:     linux-riscv@lists.infradead.org, Conor Dooley <conor@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        mturquette@baylibre.com, sboyd@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, Greg KH <gregkh@linuxfoundation.org>,
        jirislaby@kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-serial@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Conor Dooley <conor@kernel.org>
Message-ID: <mhng-8318a24b-b187-4056-ba08-3dfe2054d4fe@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 06 Apr 2023 13:57:49 PDT (-0700), Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>
> As part of converting RISC-V SOC_FOO symbols to ARCH_FOO to match the
> use of such symbols on other architectures, convert the SiFive soc
> drivers to use the new ARCH_FOO symbols.
>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  drivers/soc/sifive/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/soc/sifive/Kconfig b/drivers/soc/sifive/Kconfig
> index e86870be34c9..139884addc41 100644
> --- a/drivers/soc/sifive/Kconfig
> +++ b/drivers/soc/sifive/Kconfig
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>
> -if SOC_SIFIVE || SOC_STARFIVE
> +if ARCH_SIFIVE || ARCH_STARFIVE
>
>  config SIFIVE_CCACHE
>  	bool "Sifive Composable Cache controller"

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
