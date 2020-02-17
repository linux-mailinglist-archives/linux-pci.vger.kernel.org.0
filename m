Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85D2C160B87
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2020 08:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgBQHWv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Feb 2020 02:22:51 -0500
Received: from mail3-bck.iservicesmail.com ([217.130.24.85]:3725 "EHLO
        mail3-bck.iservicesmail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725873AbgBQHWv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Feb 2020 02:22:51 -0500
IronPort-SDR: 5dIdp8QJv3D0cVJg1LH/hbDfQdX75s0MhzeZGCocp7h28mpyuNP3Lg2NEigv9JNSFgXmgUTusr
 PlOaqdKtlWWw==
IronPort-PHdr: =?us-ascii?q?9a23=3AANCMoh0uhxFYkvNQsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8Zse0RI/ad9pjvdHbS+e9qxAeQG9mCt7Qb1qGP6/uocFdDyKjCmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfLx/IA+0oAjRucUanJduJ6gswR?=
 =?us-ascii?q?bVv3VEfPhbymxvKV+PhRj3+92+/IRk8yReuvIh89BPXKDndKkmTrJWESorPX?=
 =?us-ascii?q?kt6MLkqRfMQw2P5mABUmoNiRpHHxLF7BDhUZjvtCbxq/dw1zObPc3ySrA0RC?=
 =?us-ascii?q?ii4qJ2QxLmlCsLKzg0+3zRh8dtjqxUvQihqgRxzYDUeoGbKvlwcL7SctwGSm?=
 =?us-ascii?q?RMRdpRWi5dDY+gc4cDE/QNMOBFpIf9vVsOqh6+CBG2Cuzx1j9HmGX21rA63O?=
 =?us-ascii?q?QmFwHG0xErEtUWsHTTttX1KL0dXPuozKnOzDXDdO9W2S3n54fVaB8tu/CMXa?=
 =?us-ascii?q?5pfMfX1EIhFBvFg02OpYD4PT6ZzPkBvmaH4+Z6S+6ihHQrpg9xrzWp28wikJ?=
 =?us-ascii?q?PGhpgPxVDB7Sh5xYE1KsCmR0Njet6kFYdQtzmdN4trXsMuW2Fotzg+yr0BoZ?=
 =?us-ascii?q?O7eTIFyJUjxx7FdfOHd5SE7x35WOaPJjd3mWhqeLy4hxa070es0PPzVtKs3F?=
 =?us-ascii?q?ZLqCpKjMXMu2gT2xDO6MWLUOZx80m91TqVyQze5ftILE40mKbDLp4u2L8wlp?=
 =?us-ascii?q?4dsUTZGS/2nV37jLeRdkU+5uin8f/qYqjgpp+dLI90lhv+Pb4zlcOlG+g4Mx?=
 =?us-ascii?q?QOU3CB+eugzL3j4VH5QLJSg/0yk6nZto3aJMsCqq6hHwBV050u6wiwDzi4yt?=
 =?us-ascii?q?QUh3oHI0xfeBKBkYfpP0vCIPfiDfew0ByQl2JvxvbbLvj5CZTlMHfOivHicK?=
 =?us-ascii?q?x75koazxA8nupS/5ZFNrZUGP/vV1W5i9veAVdtKwGozvz4D9Ny1oAeQmiEKq?=
 =?us-ascii?q?CcOaLW91SP47R8DfOLYdottSrwMbAa4PjhxSshnkUBdIG025oMdGqxEv0gIl?=
 =?us-ascii?q?nPMimkucsIDWpf5ll2d+ftklDXCTM=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2G9TQABPkpelyMYgtlmgkOBPgIBgUU?=
 =?us-ascii?q?QUiASjGOGa1QGcx+DQ4ZShRaBAIMzhgcTDIFbDQEBAQEBNQIEAQGEQIIEJDw?=
 =?us-ascii?q?CDQIDDQEBBgEBAQEBBQQBAQIQAQEBAQEIFgaFc4I7IoNwIA85SkwBDgGDV4J?=
 =?us-ascii?q?LAQEKKaxxDQ0ChR6CTAQKgQiBGyOBNgMBAYwhGnmBB4EjIYIrCAGCAYJ/ARI?=
 =?us-ascii?q?BboJIglkEjVISIYlFmDSBaloElmuCOQEPiBaENwOCWg+BC4MdgwmBZ4RSgX+?=
 =?us-ascii?q?fZoQUV4Egc3EzGggwgW4agSBPGA2ON44rAkCBFxACT4tJgjIBAQ?=
X-IPAS-Result: =?us-ascii?q?A2G9TQABPkpelyMYgtlmgkOBPgIBgUUQUiASjGOGa1QGc?=
 =?us-ascii?q?x+DQ4ZShRaBAIMzhgcTDIFbDQEBAQEBNQIEAQGEQIIEJDwCDQIDDQEBBgEBA?=
 =?us-ascii?q?QEBBQQBAQIQAQEBAQEIFgaFc4I7IoNwIA85SkwBDgGDV4JLAQEKKaxxDQ0Ch?=
 =?us-ascii?q?R6CTAQKgQiBGyOBNgMBAYwhGnmBB4EjIYIrCAGCAYJ/ARIBboJIglkEjVISI?=
 =?us-ascii?q?YlFmDSBaloElmuCOQEPiBaENwOCWg+BC4MdgwmBZ4RSgX+fZoQUV4Egc3EzG?=
 =?us-ascii?q?ggwgW4agSBPGA2ON44rAkCBFxACT4tJgjIBAQ?=
X-IronPort-AV: E=Sophos;i="5.70,451,1574118000"; 
   d="scan'208";a="338052188"
Received: from mailrel04.vodafone.es ([217.130.24.35])
  by mail02.vodafone.es with ESMTP; 17 Feb 2020 08:22:50 +0100
Received: (qmail 1807 invoked from network); 17 Feb 2020 06:34:36 -0000
Received: from unknown (HELO 192.168.1.163) (mariapazos@[217.217.179.17])
          (envelope-sender <porta@unistrada.it>)
          by mailrel04.vodafone.es (qmail-ldap-1.03) with SMTP
          for <linux-pci@vger.kernel.org>; 17 Feb 2020 06:34:36 -0000
Date:   Mon, 17 Feb 2020 07:34:36 +0100 (CET)
From:   Peter Wong <porta@unistrada.it>
Reply-To: Peter Wong <peterwonghkhsbc@gmail.com>
To:     linux-pci@vger.kernel.org
Message-ID: <23324288.419891.1581921276315.JavaMail.cash@217.130.24.55>
Subject: Investment opportunity
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Greetings,
Please check the attached email for a buisness proposal to explore.
Looking forward to hearing from you for more details.
Sincerely: Peter Wong




----------------------------------------------------
This email was sent by the shareware version of Postman Professional.

