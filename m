Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6DE6E57A9
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 04:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjDRCyu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Apr 2023 22:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjDRCyt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Apr 2023 22:54:49 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D934C2F
        for <linux-pci@vger.kernel.org>; Mon, 17 Apr 2023 19:54:48 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 41be03b00d2f7-51f3289d306so196300a12.3
        for <linux-pci@vger.kernel.org>; Mon, 17 Apr 2023 19:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681786488; x=1684378488;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2EdY+MOU1TmeQWcJcFS/IvhQ+5RhMFDPkRQk2g/H9YA=;
        b=elBLaAHINYbfNLLcIz+R9zZFtyw7swFPzl0JKRGTQWokMFB5CvI8mr4g/sX4YJhcHZ
         QQrXKp8ljW7YOCngboMhoBDNwv6/yHAAOn0I//Q2pSfgCTnbS3GERd6HXvWHs8fKmgzV
         yP9ZEuquMaJU/hucgON7kJNDz9TbwkdxmmA0EMWAwSY80Jd1kWQPwkYg57SkDD92n8j7
         +sk89CyDi274qoateGf7tfgcKocv7dtR7eCIi44XAZF0eLk2ZPxD9TiqGEwRcxufbeYb
         uKVlXlWI2xw8yQwKDiAe1lmuQfv22PZHdfmufdPVPi60nyaRWTG9T9McxrjwQXrjQr8y
         zC7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681786488; x=1684378488;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2EdY+MOU1TmeQWcJcFS/IvhQ+5RhMFDPkRQk2g/H9YA=;
        b=KLYNpq7/ccXj1HOOw+zRc2CHVmM5KnOvmnU6uWI2NhqPHkGb3y0KvVmSRU2I9Mm4Vk
         2ppCSjLQXQD827+xzvuw93NLHD9A5o+Z36JeP4opR/qL9bYLZANc95FRkjjFRSaBtV2W
         5NPOLnXdexLoeLcHVpJOKhXPBRf4D1jdz/HRoOf8lww9TNXTJ9oYgrUWLsjFnUXQIVBy
         Fy1JE5WQKT78Q2cOChsr6JdUd9jbGU8T2U2D0qFtOvSD1O53tc0a/bmNMqFCbQZrF3o1
         qXVMlQ2JkxzMXBkOOGhm1P7dtROv+B0yvSRg5ihqG/+ucmWczfb8pKzs1Ygm90FOI41I
         KYvw==
X-Gm-Message-State: AAQBX9fpv72Ixb+NRTVXN4lxDEOHYgs9RuBDpuiLBZp86xFMY231fOF/
        o7RVmItZcKW8Wo44KfePaxXxMmZIYTQbTcFglRc=
X-Google-Smtp-Source: AKy350ZN4m512imBUiS5jwaMpAqP4J5JMH+ULXDboWRsY41tveuj/XCqT1Op9DoGHw8eHgTp/E4w3HlynCslHLD6KVo=
X-Received: by 2002:a17:90a:7547:b0:233:cc2c:7dae with SMTP id
 q65-20020a17090a754700b00233cc2c7daemr178153pjk.8.1681786487923; Mon, 17 Apr
 2023 19:54:47 -0700 (PDT)
MIME-Version: 1.0
Sender: lucasjarry231@gmail.com
Received: by 2002:a17:522:99ce:b0:4ef:e840:6671 with HTTP; Mon, 17 Apr 2023
 19:54:46 -0700 (PDT)
From:   Sophia Erick <sdltdkggl3455@gmail.com>
Date:   Tue, 18 Apr 2023 04:54:46 +0200
X-Google-Sender-Auth: oO6k3yUPVm70PbooBVJ-hVYqnT0
Message-ID: <CAMXDO3VNEYRsENKgw+L16UAQOO8akiYqZboiNp4jj6rKYdRrYQ@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,HK_RANDOM_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Dearly Beloved In Christ,

Please forgive me for stressing you with my predicaments as I directly
believe that you will be honest to fulfill my final wish before i die.

I am Mrs.Sophia Erick, and i was Diagnosed with Cancer about 2 years
ago, before i go for a surgery i have to do this by helping the
Orphanages home, Motherless babies home, less privileged and disable
citizens and widows around the world,

So If you are interested to fulfill my final wish by using the sum of
Eleven Million Dollars, to help them as I mentioned, kindly get back
to me for more information on how the fund will be transferred to your
account.

Warm Regards,
Sincerely Mrs. Sophia Erick.
