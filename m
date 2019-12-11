Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5258711C0A7
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2019 00:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbfLKXil (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Dec 2019 18:38:41 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:44095 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfLKXil (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Dec 2019 18:38:41 -0500
Received: by mail-wr1-f51.google.com with SMTP id q10so552833wrm.11;
        Wed, 11 Dec 2019 15:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:mime-version:message-id:user-agent
         :content-transfer-encoding;
        bh=9MD2iuL/4WQUUIETBvkMoKCxMANv9+K7ltNUru8sZLQ=;
        b=Za9dk0f3+8Oo2BcaPZmBbpc29b3C6CmCFARBm9fTHh/QLUWgUu5TSJr9ppy8bkCdrc
         H/Zs90vGg4yF2K3w5woCtLhBCGBREAC1ocKIG3+pB+wiIO4NxrOHH3iI6/38Dd0vbjMg
         qFTUiuois9HPXxl9PR6eLbt6Lk8Bi9eEli3Rdl8mq/mzwsvpdHLVpxgdV4O5587xza97
         ydALyXp3GgqPyRbvcu8+UuPLpE8ZG9qw5YFuoj3sesJJk3j3EoMXB6+mSPzTfzmY0ZcY
         7KFxamKx4iTGmrzz8dSXEFpas10CjMjE6bX/g7Nlz2sMXrNJOXZOt+Ujtfcfm/v1JW6k
         3Qcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:mime-version:message-id
         :user-agent:content-transfer-encoding;
        bh=9MD2iuL/4WQUUIETBvkMoKCxMANv9+K7ltNUru8sZLQ=;
        b=YIWRT95AhiLawdzUfw770XytlmAnSohh0CUwSFg9pO/StPdGQHIzMVYAA56H3u8LHq
         SIRAjePrT1aL8NoiY6qAQZrHLzCIssZcOVxg0WgKlnT1lXzxy3D2/9mraD5pQVXRq5ZC
         +NYHpI6acu3oKGIk3yvO4/KaeFh7iNaW3A2pPMbobxS5OWyuyKuj1CJSELcHiGQMVZHT
         FW8WYMVaW81W4BqjVxPLBtqLUHdx83Y2xtA6o92sqo75jmPJhWoVinF11BOJX91NJi9R
         bNbNKlyQXI/qCuMBFLUMtU93wLiHw83nq/Qjd4WXcbmpNNhSHzelTaoY8QtU+EO9mQUh
         gqjg==
X-Gm-Message-State: APjAAAXrvcaw4LEChn6QSWhzl5ODWkm6D1VHWATOhWwSqrBZGozRYo/a
        YL4JFmjXCCbDs/vLX/g2S2A=
X-Google-Smtp-Source: APXvYqyt9+nph0QrBPM/FnhfUGZMJLtmYaY8jJjnZzNW2cdfqWXBK8OyEytjvDss5jLs0ZDLutaJ+A==
X-Received: by 2002:a5d:68cf:: with SMTP id p15mr2640601wrw.31.1576107518523;
        Wed, 11 Dec 2019 15:38:38 -0800 (PST)
Received: from localhost ([5.59.90.131])
        by smtp.gmail.com with ESMTPSA id w20sm3995604wmk.34.2019.12.11.15.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 15:38:37 -0800 (PST)
From:   Vicente Bergas <vicencb@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "\"Rafael J. Wysocki\"" <rafael.j.wysocki@intel.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?iso-8859-1?Q?=22Stefan_M=E4tje=22?= <stefan.maetje@esd.eu>,
        Frederick Lawler <fred@fredlawl.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [REGRESSION] PCI v5.5-rc1 breaks google kevin
Date:   Thu, 12 Dec 2019 00:38:35 +0100
MIME-Version: 1.0
Message-ID: <58ce5534-64bd-4b4b-bd60-ed4e0c71b20f@gmail.com>
User-Agent: Trojita
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,
since v5.5-rc1 the google kevin chromebook does not boot.
Git bisect reports=20
5e0c21c75e8c PCI/ASPM: Remove pcie_aspm_enabled() unnecessary locking
as the first bad commit.

In order to revert it from v5.5-rc1 i had to also revert some dependencies:
5e0c21c75e8c08375a69710527e4a921b897cb7e
aff5d0552da4055da3faa27ee4252e48bb1f5821
35efea32b26f9aacc99bf07e0d2cdfba2028b099
687aaf386aeb551130f31705ce40d1341047a936
72ea91afbfb08619696ccde610ee4d0d29cf4a1d
87e90283c94c76ee11d379ab5a0973382bbd0baf
After reverting all of this, still no luck.
So, either the results of git bisect are not to be trusted, or
there are more bad commits.

By "does not boot" i mean that the display fails to start and
the display is the only output device, so debugging is quite difficult.

v5.5-rc1 as is (reverting no commits at all) works fine when disabling PCI:
# CONFIG_PCI is not set

Regards,
  Vicente.

