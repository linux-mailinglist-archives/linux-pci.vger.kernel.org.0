Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6E77CBACF
	for <lists+linux-pci@lfdr.de>; Tue, 17 Oct 2023 08:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbjJQGSV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Oct 2023 02:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233862AbjJQGSV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Oct 2023 02:18:21 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DF7B6
        for <linux-pci@vger.kernel.org>; Mon, 16 Oct 2023 23:18:19 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-419b232fc99so25351731cf.1
        for <linux-pci@vger.kernel.org>; Mon, 16 Oct 2023 23:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697523499; x=1698128299; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ceHtW9H2siBIBWG0gigB6B/LkLmcRGMR+a2ck1IcBwg=;
        b=itGyNKLh5nD1XdD2ScLb24lq0uYk/PmlTQWibS/0cfoFatDws3i48nHE/4rwZpBvik
         +LyFalHUyQOTCwEpSYYZqKhD0u7pUOOqltZQHRrRtSOnmpBO7Fvn7s/sdpHFf77ogGyF
         1PTsEFlGqsY81FU6pKCCdpd/H1Efpb69Uvbzm0Z4sm9vlbTTgJ7YfArMyvv/OOJqCrp7
         RS/roOxog5kT2rkvRfXgebzko0STCiL9Dh0Ktk+g3q7CWirIXhyaWXsdrcUAd6exEVYN
         0nBMrbcIto55JCDQyluk4RWRLfPMsWYZ9BDaF+3SaI25IwOwlX4BTXMCB1LTrdMH+rpB
         l4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697523499; x=1698128299;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ceHtW9H2siBIBWG0gigB6B/LkLmcRGMR+a2ck1IcBwg=;
        b=updR8pP3rL5dEOIJsGBJFvX9lwkijBxj3nB3l5mcCDY51rqPdji+db/+JYR2YR5UrN
         CYAeydo78ldFTvd6HJTUo24bk6XoK3rDovz//MfFLwh8x18QR2w9h2kec6Wleem4hdkR
         QjA7MwyduSoJTgxXTULiBMa/IVbclRitxE4fCLuDnEhi3pN9sWxmfUmxVg2Lf4y1CmoH
         7XBI3s6fBBymi59OAIFwk/6CCQOjvebtC4jsmnwMXPbraMR0JHtTalXjX7t9qsfuNbjm
         Kw9J9OCz9wcH0k2p6GZ6vetsXvKr9dcQFHV9ZeegB8m4NnaD62IJjpy2AZpy6QlbE9Km
         J+vw==
X-Gm-Message-State: AOJu0YyoxOytSHBWyhkFoJRizRH5tSrdgnU5wIYMleQMhNmH9obOvuCd
        ksESucbvGRiiOsFOphALb7YG
X-Google-Smtp-Source: AGHT+IH6onFgtojbAPtwq1nUfbLTYNwEUGI4rAghxeeUTFIt3K42uOklPDt+jOdwnKGTSf3yCD3soA==
X-Received: by 2002:a05:6214:1d2d:b0:66d:5ee5:8158 with SMTP id f13-20020a0562141d2d00b0066d5ee58158mr1444238qvd.55.1697523498769;
        Mon, 16 Oct 2023 23:18:18 -0700 (PDT)
Received: from [127.0.1.1] ([117.207.31.199])
        by smtp.gmail.com with ESMTPSA id f22-20020a05620a12f600b00765aa3ffa07sm390304qkl.98.2023.10.16.23.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 23:18:18 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/2] PCI: dwc: Fix the BAR size programming
Date:   Tue, 17 Oct 2023 11:47:53 +0530
Message-Id: <20231017-pcie-qcom-bar-v1-0-3e26de07bec0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABEnLmUC/x3MQQqAIBBA0avErBvQlIquEi1smmoWpSlEEN49a
 fkW/7+QOAonGKoXIt+SxJ8Fuq6AdndujLIUQ6Mao5XuMJAwXuQPnF1Esn1ryBhSbKE0IfIqz/8
 bp5w/w+Gnn18AAAA=
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1599;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=Gcs3HOsPBfF3cIkTmKhbvwJROzoVyq0co8h182wgdmE=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBlLicmF9zGtxWxnm6EWnPLFh5TL2I/hR68hJ1zH
 Tam/uqLLgGJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZS4nJgAKCRBVnxHm/pHO
 9dfhB/9woGeMPND3WMkroRyWsqHjVp1whwd/ogF3rdrot3nWX4fUaqcueDpak9RrFwEDZgbrFb9
 O/qOPzSYtzKqFXb3qHDuZA2PBcnqjn1qjkt3wCP4YXdgmjc96pLNqceOJbVh81CoWTVqoFiamHo
 C9BzkENnesEWp4imFCwGHA69LMob07hExBKMIvVZO8GHK0qnJSaaJrn0ir47nYzzODaNh2yvKcI
 lAr8fdn3yHK89loUJbefFNqrlDus4Y9PYnn/kfLRqRHirG21jUJp8GM+hXc91iq0WLAgmRO7yFC
 JtO+wTjsnHqQHvegM8vG3TBej2R2dzmTFcinDNsCcC1/zDHj
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

This series fixes the issue seen on Qcom EP platforms implementing the DWC
core while setting the BAR size. Currently, whatever the BAR size getting
programmed through pci_epc_set_bar() is not reflected on the host side
during enumeration.

Debugging that issue revealed that the DWC Spec mandates asserting the DBI
CS2 register in addition to DBI CS while programming some read only and
shadow registers. On the Qcom EP platforms, the BAR mask register used to
program the BAR size is marked as read only (RO). So the driver needs to
assert DBI CS2 before programming and deassert it once done.

Hence, this series adds two new macros for asserting/deasserting the DBI
CS2 while programming BAR size and also introduces a new host callback,
dbi_cs2_access() that the vendor drivers can implement.

For platforms not requiring the DBI CS2 access, this is a no-op.

This series has been tested on Qcom SM8450 based development platform.

---
Manivannan Sadhasivam (2):
      PCI: dwc: Add new accessors to enable/disable DBI CS2 while setting the BAR size
      PCI: qcom-ep: Implement dbi_cs2_access() function callback for DBI CS2 access

 drivers/pci/controller/dwc/pcie-designware-ep.c |  6 ++++++
 drivers/pci/controller/dwc/pcie-designware.h    | 13 +++++++++++++
 drivers/pci/controller/dwc/pcie-qcom-ep.c       | 14 ++++++++++++++
 3 files changed, 33 insertions(+)
---
base-commit: a286439bbc71e8c9bb1660b7d4775efcab6011fa
change-id: 20231017-pcie-qcom-bar-c4863c33c0e4

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

