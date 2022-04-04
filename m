Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15034F1CD8
	for <lists+linux-pci@lfdr.de>; Mon,  4 Apr 2022 23:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380466AbiDDV3O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Apr 2022 17:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380368AbiDDTuT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Apr 2022 15:50:19 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D44730F6A
        for <linux-pci@vger.kernel.org>; Mon,  4 Apr 2022 12:48:21 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id 246001F43BF6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649101700;
        bh=daPzz5ykE2J9Xwa1bkkezG/6izbYPno5w+c0Kcjkp2w=;
        h=Date:Subject:From:To:Cc:Reply-To:References:In-Reply-To:From;
        b=e9r6rANqSb5rqAzq9JeevE5FKfPDRNWCGFlAARCTNlPn8KJw++hYLWauIa9GcQ6yj
         2Kgqy41Mum7vy3FttQS6taKXED7bgItVmVR6e42f8PGc75D+DS78x9JBedCHk0nZQU
         bfGNQcIeQb5O5BX6MHNx4t1d1pdLLeGv+Uvra0Ycm2fkz011JVFgfdeMd4HkLN8pMJ
         02/FMX8z0BCxrsFEkFFbMt7XPhiW61NL9nf6kQE0HhdG1NS8NVh581rkvKd+jYobCu
         5kK7/ftqSskq1bJ8FCzZ7fEM7QaGdGDCMm6ookaIGobFhw2oAxP1V8be6JClmVSZyW
         CHOy6R+/v4NLQ==
Message-ID: <73a7cc3c-9d51-3e44-a4e4-cd116ffccc92@collabora.com>
Date:   Mon, 4 Apr 2022 20:48:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: next/master bisection: baseline.login on asus-C523NA-A20057-coral
Content-Language: en-US
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org,
        "kernelci@groups.io" <kernelci@groups.io>,
        "kernelci-results@groups.io" <kernelci-results@groups.io>
Reply-To: kernelci@groups.io, guillaume.tucker@collabora.com
References: <623c13ec.1c69fb81.8cbdb.5a7a@mx.google.com>
 <Yjyv03JsetIsTJxN@sirena.org.uk>
 <4e9fca2f-0af1-3684-6c97-4c35befd5019@redhat.com>
 <Yjzua8Wye/3DHBKx@sirena.org.uk>
 <f8e96f8a-c19c-6acd-2f54-688924f491e8@redhat.com>
 <28699579-8384-ff3b-5662-fb56d8ced766@collabora.com>
 <16E2C910B4947F17.5433@groups.io>
In-Reply-To: <16E2C910B4947F17.5433@groups.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 04/04/2022 20:44, Guillaume Tucker wrote:
> Well the issue seems to have been fixed on mainline

Sorry, I meant linux-next.  It is also booting on mainline but I
don't think the regression ever went further than linux-next:

  https://linux.kernelci.org/test/plan/id/6246654e60a1cb470cae0680/

Guillaume
