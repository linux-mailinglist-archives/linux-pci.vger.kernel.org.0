Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C230500321
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 02:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238659AbiDNAsL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Apr 2022 20:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237899AbiDNAsL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Apr 2022 20:48:11 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FF22C136
        for <linux-pci@vger.kernel.org>; Wed, 13 Apr 2022 17:45:48 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id v15so4402030edb.12
        for <linux-pci@vger.kernel.org>; Wed, 13 Apr 2022 17:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=we9Txi2+echyX2V89cW/3QY237luayT2DX0RqtHgrdY=;
        b=D34D3nDKXXUl8++Ga5pBAA8ROP7PLGeRuMch7JNJBwvB7ceYxS6YASJkLTbZIJHzq9
         xHTvun5HcpJqPrJcklT4ksaKA6KkMp50TQfo+DdPqT6LJXmSUWz+TSigohaDH070hCXd
         72p3UV0aiOwXXLmmf+GnoApqfeP4q7b0G9+DZG5z1WQsUxKaSBnBLGw6mq21zUMTT7dF
         pfPqjz5xOo5iyK3msMvOURmguTn1/H9g0EACSH6Em/a0rQT7r2pph6eOCFMZI6QV/vGY
         YsvKy7QTg05nW4VGT1MF22OQZJqmzL/bg4wLFIsmjQdx+GPY9p2W48sd7ld3FqQtClmp
         bQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=we9Txi2+echyX2V89cW/3QY237luayT2DX0RqtHgrdY=;
        b=7UuLMXt33owvcTAD0n1lPrWhM2+k2CkFdJK6k7KSmBOsZyODrkP8yx1q6V8n1MEiJj
         uwA6FcmhqSagk817ooShbWZH0iSOJeyP0KGFLXYS/dJMPZl5t3ea5r9mg4HTNEHPHIfZ
         IDBSqxDN1UunFo2ByatANr8KS+XxY4OngGnV7Mvpw6+LrqRC1ycX8ns+gSDcg3+WAdS4
         kh9keVgBn3Og3Mg8Qg2WpnWRM1aZ2lxlx3sJBXHBk/eI3NqCF9UEZDMc86uJODmscjnI
         GSO0q0R53fgsfJJR05/ln7wiQNFbxjjn8dMf62hlgWip2GBZy64/zB/nZOUDfqHs62YV
         PeVA==
X-Gm-Message-State: AOAM530A+Q2LsCMEC2O7RWs2lMQNnGHjiIwZxBJL8u8hnYtsXGQsb45R
        PY0ReBSR5P5s53gncWeWmsS4oLV70qdnaM96Ez8=
X-Google-Smtp-Source: ABdhPJzpsjIqOnj3RgkkKt4GViOm3JfJc6sZhxsOff/k9ep6HrLFJDcCaeRND1w/Mwx19Y0KZojTdRtOPUsRU5/TBec=
X-Received: by 2002:a05:6402:1112:b0:413:3d99:f2d7 with SMTP id
 u18-20020a056402111200b004133d99f2d7mr256584edv.23.1649897147089; Wed, 13 Apr
 2022 17:45:47 -0700 (PDT)
MIME-Version: 1.0
From:   J <jessicadave303@gmail.com>
Date:   Thu, 14 Apr 2022 00:45:34 +0000
Message-ID: <CALEbFpfht-vNGxd+aVECbCa12pkzKwKwkmsVPoB8RmdJT05TEw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I'm Jessica Dave, from the Philippines, please I wish to communicate with you.

I wait for your reply.

(Jessica)
