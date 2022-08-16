Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7AE59625F
	for <lists+linux-pci@lfdr.de>; Tue, 16 Aug 2022 20:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237092AbiHPS0I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Aug 2022 14:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237027AbiHPS0C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Aug 2022 14:26:02 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E3A86B5C
        for <linux-pci@vger.kernel.org>; Tue, 16 Aug 2022 11:25:57 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id bs25so13637373wrb.2
        for <linux-pci@vger.kernel.org>; Tue, 16 Aug 2022 11:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=i14dSapeS6A95og3h5kVrEaeQxUOEEcffvmz7W7v7mg=;
        b=SFfhLwGA1m3W49evekpktH/l4IitnbDTV07fTcveNPx+SVDpmrIhLDWbuuqx94qZCQ
         3k4dwlMnCtECF1kUYylgBOCmMmcHMH2BGHCInV4vx1IHN8RZaI7SxCTkW5Z+hlZS0pAA
         px1nzTkEaWBBn7CjvMDvM064Rs4nvR8/vGfqGAmsu49ckurodNOHilwC9LJa56thDAbT
         fU7QmYIp9OyTLf3KIAqEXBh1A0W0uJtqQZaIYZdz+q8dQ1n7mQFlY6ZF6w4BS1wiBa12
         dc5ffczB0xcWpaLya62H3cEkimt/Lu4jTTZtqctIcDm6rpHHOEgxMLffokpP/uAwnuDD
         gI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=i14dSapeS6A95og3h5kVrEaeQxUOEEcffvmz7W7v7mg=;
        b=d0heU4+heayVsBI6qUn2JXzpkFRaz8G3AaPOaK1RfIVXJ8h8yO5g1UT0utBX8lkqSF
         fjwDH4J5QCak05BNlJD7DqGoXXJgusBdzSyWNBEQXKtY0in9NmoijL5GdrQDr1okpxnz
         52BUrqP7tBGdrZFlH95EaoudvSdnKsniNgtFMNr/l7IXP6FLHzgC/swKW3bzLSuWZ6nL
         vADqaJddgETeaOLCtuVuFub+XbAMysb4syzAG4e+urK0cZE+7/yG9zrxU65KR+Dns6zn
         8WwyUSA+IWKue6QcxJ2esvrcjAmuD5Q1iDT/SQTUBMe6TBZiZBOgz+EsT0WXyzJMKoat
         9cDA==
X-Gm-Message-State: ACgBeo18DPnO1WudUBOD7qlxzhkhzlx//KGLJAyseOOORCC5+MbyMWHd
        nwn2AGKAvwhG6BgwnbIuuINSDA==
X-Google-Smtp-Source: AA6agR6bTwH/YxxR5LcBXZI5QTnN9mSXoYCK/TmLm8WaQxf55ygx9S28F9mU7Vc29aiDwpv9EgOsEQ==
X-Received: by 2002:adf:f74b:0:b0:225:1fdb:a787 with SMTP id z11-20020adff74b000000b002251fdba787mr1250471wrp.33.1660674355174;
        Tue, 16 Aug 2022 11:25:55 -0700 (PDT)
Received: from henark71.. ([109.76.58.63])
        by smtp.gmail.com with ESMTPSA id s17-20020a1cf211000000b003a603fbad5bsm4015482wmc.45.2022.08.16.11.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 11:25:54 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     Daire McNamara <daire.mcnamara@microchip.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v2 0/6] Fix RISC-V/PCI dt-schema issues with dt-schema v2022.08
Date:   Tue, 16 Aug 2022 19:25:42 +0100
Message-Id: <20220816182547.3454843-1-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Hey all,

Got a few fixes for PCI dt-bindings that I noticed after upgrading my
dt-schema to v2022.08. (and the associated dts now too)

Since all the dts patches are for "my" boards, I'll take them once the
bindings are approved. I added a pair of other dts changes to the series,
mostly for my own benefit in tracking what I need to apply that were
previously at [0] & [1].

Thanks,
Conor.

0 - https://lore.kernel.org/all/20220811203207.179470-1-mail@conchuod.ie/
1 - https://lore.kernel.org/all/20220811204024.182453-1-mail@conchuod.ie/

Changes since v1:
- fu740: rewrite commit message
- mchp: rework clock-names as per rob's suggestion on IRC
- mchp: drop the "legacy" from the node name
- mchp: renemove the address translation property
- mchp: change the child node name in the dts rather than the binding

Conor Dooley (6):
  dt-bindings: PCI: fu740-pci: fix missing clock-names
  dt-bindings: PCI: microchip,pcie-host: fix missing clocks properties
  riscv: dts: microchip: mpfs: fix incorrect pcie child node name
  riscv: dts: microchip: mpfs: remove ti,fifo-depth property
  riscv: dts: microchip: mpfs: remove bogus card-detect-delay
  riscv: dts: microchip: mpfs: remove pci axi address translation
    property

 .../bindings/pci/microchip,pcie-host.yaml     | 25 +++++++++++++++++++
 .../bindings/pci/sifive,fu740-pcie.yaml       |  6 +++++
 .../boot/dts/microchip/mpfs-icicle-kit.dts    |  3 ---
 .../boot/dts/microchip/mpfs-polarberry.dts    |  3 ---
 arch/riscv/boot/dts/microchip/mpfs.dtsi       |  3 +--
 5 files changed, 32 insertions(+), 8 deletions(-)

-- 
2.37.1

