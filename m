Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3048C73BA65
	for <lists+linux-pci@lfdr.de>; Fri, 23 Jun 2023 16:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjFWOlU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Jun 2023 10:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbjFWOlN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Jun 2023 10:41:13 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFC51B4
        for <linux-pci@vger.kernel.org>; Fri, 23 Jun 2023 07:41:08 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-763d6e8e286so55852685a.0
        for <linux-pci@vger.kernel.org>; Fri, 23 Jun 2023 07:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1687531267; x=1690123267;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1qoeaOs3mg4C8x/f28b+enrCuX2UR5msJGKgFyz/FK4=;
        b=M/lYlfNg0Cdmtk9VHtgpjxWm3wVvK8MA7rPKZb2Kpx7iZl1WN6y13/ZPrtyj8vSvFQ
         7b1BI6ny8w56ekeC6d2z0vhUXlrP2kAqXKpl5hTw5HQyjGoybjTBWLq/aGQT8IIR/fNH
         vcX7f1t+1m0zKdZS4w3NxWMqTMpUhNNCiRfVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687531267; x=1690123267;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1qoeaOs3mg4C8x/f28b+enrCuX2UR5msJGKgFyz/FK4=;
        b=lAqAla2ipp7poHTQsv21JEmNyE7zRwe7hHxrcwyRv24Sti/LIYX46BV+TAopOU5pDP
         RJ71uZo8j5jaEoYdvjSo7fbm8fAfRE1AoD3Dg+XhAsempQz4SR19GOvZcticnI3FccR9
         JUHVlUgcCyd82lS06DMuqfEageaqzoz9e2ai2gnZbBPjGj5pyW1IxQxykW2W32mle3j+
         DVk3KjCmH1ZJ9pR2rmAjLSAH4Kke4ZXIzC7A8vRL9M7sPgty4dsrm3SYXOnBefDKx7Ri
         +LBwA5dQtL4ye5By27pF45HoOf/62pmcGANz7DTniclCYm7tt93ERoNjWIaHu8LZ/8TM
         ZNSw==
X-Gm-Message-State: AC+VfDzfqlrOZfsTZ8LhUBIvT+Et7BoBqvvYIP1LFVCktoBw0ZjJL3um
        tZP47WT1BGl2yOSQ0nFGKavJ+W1EXhfMMLIp9vLoVNowf6Qeit6m2FcfzmGZmN1PYQBrBRF13HX
        /pfMNkcKJKPjigEFo3kgWMelBw7VgiiBLpf7Avx+IIncX1FT151rCEmSRFOsM3CPx0+HnhRemvB
        dkBmoGO9uf0A==
X-Google-Smtp-Source: ACHHUZ4IhPOL36VKR59tEJb2o3jA3l9pE226IcXVgSMSrQ3gKkdN8Hy1S9e4HdB1zSqef7hIlazxqw==
X-Received: by 2002:a05:620a:2b47:b0:75b:23a1:40f with SMTP id dp7-20020a05620a2b4700b0075b23a1040fmr21782878qkb.37.1687531266514;
        Fri, 23 Jun 2023 07:41:06 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id i18-20020a05620a145200b007625382f4ccsm4564613qkl.69.2023.06.23.07.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 07:41:06 -0700 (PDT)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Conor Dooley <conor+dt@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), Florian Fainelli <f.fainelli@gmail.com>,
        Jim Quinlan <jim2101024@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v6 0/5] PCI: brcmstb: Configure appropriate HW CLKREQ# mode
Date:   Fri, 23 Jun 2023 10:40:53 -0400
Message-Id: <20230623144100.34196-1-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000b854b805feccfd2f"
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        MIME_HEADER_CTYPE_ONLY,MIME_NO_TEXT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--000000000000b854b805feccfd2f

v6 -- No code has been changed.
   -- Changed commit subject and comment in "#PERST" commit (Bjorn, Cyril)
   -- Changed sign-off and author email address for all commits.
      This was due to a change in Broadcom's upstreaming policy.

v5 -- Remove DT property "brcm,completion-timeout-us" from	 
      "DT bindings" commit.  Although this error may be reported	 
      as a completion timeout, its cause was traced to an	 
      internal bus timeout which may occur even when there is	 
      no PCIe access being processed.  We set a timeout of four	 
      seconds only if we are operating in "L1SS CLKREQ#" mode.
   -- Correct CEM 2.0 reference provided by HW engineer,
      s/3.2.5.2.5/3.2.5.2.2/ (Bjorn)
   -- Add newline to dev_info() string (Stefan)
   -- Change variable rval to unsigned (Stefan)
   -- s/implementaion/implementation/ (Bjorn)
   -- s/superpowersave/powersupersave/ (Bjorn)
   -- Slightly modify message on "PERST#" commit.
   -- Rebase to torvalds master

v4 -- New commit that asserts PERST# for 2711/RPi SOCs at PCIe RC
      driver probe() time.  This is done in Raspian Linux and its
      absence may be the cause of a failing test case.
   -- New commit that removes stale comment.

v3 -- Rewrote commit msgs and comments refering panics if L1SS
      is enabled/disabled; the code snippet that unadvertises L1SS
      eliminates the panic scenario. (Bjorn)
   -- Add reference for "400ns of CLKREQ# assertion" blurb (Bjorn)
   -- Put binding names in DT commit Subject (Bjorn)
   -- Add a verb to a commit's subject line (Bjorn)
   -- s/accomodat(\w+)/accommodat$1/g (Bjorn)
   -- Rewrote commit msgs and comments refering panics if L1SS
      is enabled/disabled; the code snippet that unadvertises L1SS
      eliminates the panic scenario. (Bjorn)

v2 -- Changed binding property 'brcm,completion-timeout-msec' to
      'brcm,completion-timeout-us'.  (StefanW for standard suffix).
   -- Warn when clamping timeout value, and include clamped
      region in message. Also add min and max in YAML. (StefanW)
   -- Qualify description of "brcm,completion-timeout-us" so that
      it refers to PCIe transactions. (StefanW)
   -- Remvove mention of Linux specifics in binding description. (StefanW)
   -- s/clkreq#/CLKREQ#/g (Bjorn)
   -- Refactor completion-timeout-us code to compare max and min to
      value given by the property (as opposed to the computed value).

v1 -- The current driver assumes the downstream devices can
      provide CLKREQ# for ASPM.  These commits accomodate devices
      w/ or w/o clkreq# and also handle L1SS-capable devices.

   -- The Raspian Linux folks have already been using a PCIe RC
      property "brcm,enable-l1ss".  These commits use the same
      property, in a backward-compatible manner, and the implementaion
      adds more detail and also automatically identifies devices w/o
      a clkreq# signal, i.e. most devices plugged into an RPi CM4
      IO board.


Jim Quinlan (5):
  dt-bindings: PCI: brcmstb: Add brcm,enable-l1ss property
  PCI: brcmstb: Configure HW CLKREQ# mode appropriate for downstream
    device
  PCI: brcmstb: Set higher value for internal bus timeout
  PCI: brcmstb: Assert PERST# on BCM2711
  PCI: brcmstb: Remove stale comment

 .../bindings/pci/brcm,stb-pcie.yaml           |  9 ++
 drivers/pci/controller/pcie-brcmstb.c         | 91 ++++++++++++++++---
 2 files changed, 89 insertions(+), 11 deletions(-)


base-commit: 8a28a0b6f1a1dcbf5a834600a9acfbe2ba51e5eb
-- 
2.17.1


--000000000000b854b805feccfd2f
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
mOAplh6h3nMZUZxBguxG3g2p3iD4EgibUYneEzqOQafIQB/naf2uetKb8y9jKgWJxq2Y4y8Jqg2u
uVIO1AyOJjWwqdgN+QhuIlat+qZd03P48Gim9ZPEMDUCAwEAAaOCAdswggHXMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJQYDVR0R
BB4wHIEaamFtZXMucXVpbmxhbkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQwHwYD
VR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFGx/E27aeGBP2eJktrILxlhK
z8f6MA0GCSqGSIb3DQEBCwUAA4IBAQBdQQukiELsPfse49X4QNy/UN43dPUw0I1asiQ8wye3nAuD
b3GFmf3SZKlgxBTdWJoaNmmUFW2H3HWOoQBnTeedLtV9M2Tb9vOKMncQD1f9hvWZR6LnZpjBIlKe
+R+v6CLF07qYmBI6olvOY/Rsv9QpW9W8qZYk+2RkWHz/fR5N5YldKlJHP0NDT4Wjc5fEzV+mZC8A
AlT80qiuCVv+IQP08ovEVSLPhUp8i1pwsHT9atbWOfXQjbq1B/ditFIbPzwmwJPuGUc7n7vpmtxB
75sSFMj27j4JXl5W9vORgHR2YzuPBzfzDJU1ul0DIofSWVF6E1dx4tZohRED1Yl/T/ZGMYICbTCC
AmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UE
AxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMSO43VW7D5NP1X/KD
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBtxL8RMLunDIgGqX5eQlnAPPGkyeWM
uRARfSw+IGtAgDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMzA2
MjMxNDQxMDdaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAIDhRdeq+1+RLWq6LSDCzcpVKoUtnAxFO8KXb5sRhAbvd0rfC
JDO+BNFbj8FMDYDXnqxlgQFROSi8yBgIW4MPMo3O56R1hWm0RqppjuwTfTcHN3v+XU8kRf5hwCPu
86CxgpDybGvVVvB8Q0VyEpEgPA4Zg4zBfP2GN/W6YrxYbWN5HkCCJ4bllKBJYBljsohyVpwNc31L
rvz2BQZB/sj+Qm6PNPClRMRuQD+7HnbuIpuA9qSwz8u0e/XMxL+3iHT/2tVF3mNQiw3buolqH2Mo
spKvvzgv324Owrp/cYZlwxSa0pkpAefZ8cRI15Q/pUzF/pIDX43Wu01z0VXTV+v2UQ==
--000000000000b854b805feccfd2f--
