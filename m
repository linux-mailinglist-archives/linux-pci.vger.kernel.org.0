Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9F878885D
	for <lists+linux-pci@lfdr.de>; Fri, 25 Aug 2023 15:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbjHYNWK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Aug 2023 09:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245150AbjHYNVi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Aug 2023 09:21:38 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990B5198E;
        Fri, 25 Aug 2023 06:21:36 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68c0cb00fb3so384359b3a.2;
        Fri, 25 Aug 2023 06:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692969696; x=1693574496;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fg1k8D4jqyirfX8RpTxGNggTmqOWg26Spe4chCq3HRI=;
        b=UClsP7r30+Kb63tf+IzBQqimn/CPhKYZjnGa4Enh6cA/8bIIkRUqSEaKFRXW3PtqnE
         yqca3GmkSm6JfvOXgDwYyh2xnd8MGCGimY66jU1tExA/k363E6RpL3JiFP78GSxhEqLM
         WjoLUZubHaE3jqYEOAbX8XOh1AJjH0V2PovUEVSSc7Z2bf5NtsKm7eaMwyveUY/q4/Bc
         3mCnDTLCW4lxAbyViPQ6sC0U36PYNnoIHQhtZ5iL2MNI+bMeS2GmEwJa6MK2hCl4nhMc
         sp4awFTU8Zc00aFDPqXQ4g5u5XQt2HWYzs3GM22XKDkOu3KEYwPkSwaoJpByHA3WyZsR
         j9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692969696; x=1693574496;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fg1k8D4jqyirfX8RpTxGNggTmqOWg26Spe4chCq3HRI=;
        b=bKoK/V+BGucrkSrMc5Sem17PJVLGjaILZZPbfVxAqg811x2Hy58TBqmF02eHnJHgHo
         yPrmeVEKtEYzRo1lfZCi9l7VsMAuTmcHQ/Rkt0UVzHEMx8oDdVRrP/RMEmr7zABQYuOE
         qJtldLfc93n6MfU6YbqdND/1CC0UGvixMCVjyKWVkytzbWR4XmtbQdHxS+YArgiulDAu
         Q96vg4iVpLoDav5rKG5P2Rmf+S64uRl2Ck8bOC5IDoqgsFhCpHmqx+ecdt1MBDT2VwMo
         YBr7LSOEd5YAVqpEuewMzZIhtM1qPB42T2gLU7c0U47PZwvxDiSCzJy9VGWHb4NcFumU
         md0g==
X-Gm-Message-State: AOJu0YwKsWgUs6mMF5ILusLlAS+Ka3S+mC2o2WiJzXf5K0pf4X4WqFda
        C2vftBSFNXih88QPNBaZYxk=
X-Google-Smtp-Source: AGHT+IF7nb/ag/TltvGOdR521C/lFGSJ8njo3ubR77iqEKS5srrrFX/i2CtD5vFrOrnGlIfKeZT9aw==
X-Received: by 2002:a05:6a21:3393:b0:131:a21:9f96 with SMTP id yy19-20020a056a21339300b001310a219f96mr25202041pzb.6.1692969696027;
        Fri, 25 Aug 2023 06:21:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a19-20020a62e213000000b0068893a5a848sm1517534pfi.184.2023.08.25.06.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 06:21:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 25 Aug 2023 06:21:34 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/14] hwmon: (sis5595) Do PCI error checks on own line
Message-ID: <d3c634d0-1e0f-4a74-9e5c-1090d5914ba1@roeck-us.net>
References: <20230824132832.78705-1-ilpo.jarvinen@linux.intel.com>
 <20230824132832.78705-14-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230824132832.78705-14-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 24, 2023 at 04:28:31PM +0300, Ilpo Järvinen wrote:
> Instead of if conditions with line splits, use the usual error handling
> pattern with a separate variable to improve readability. Handle error
> print with a label instead of trying to chain everything into a single
> if condtion.

s/condtion/condition/

Applied, after fixing that up.

Thanks,
Guenter
