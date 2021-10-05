Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBE6D4230F4
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 21:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235206AbhJETu6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 15:50:58 -0400
Received: from mail.imserv.org ([46.232.251.232]:60632 "EHLO mail.imserv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235157AbhJETu5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Oct 2021 15:50:57 -0400
X-Greylist: delayed 338 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Oct 2021 15:50:56 EDT
To:     pali@kernel.org
Cc:     ath10k@lists.infradead.org, bhelgaas@google.com,
        ilias.apalodimas@linaro.org, kabel@kernel.org,
        kvalo@codeaurora.org, kw@linux.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-wireless@vger.kernel.org,
        robh@kernel.org, thomas.petazzoni@bootlin.com, toke@redhat.com,
        vtolkm@gmail.com
References: <20210505163357.16012-1-pali@kernel.org>
Subject: Re: [PATCH v3] PCI: Disallow retraining link for Atheros chips on
 non-Gen1 PCIe bridges
From:   Jannis <jannis@imserv.org>
Message-ID: <924d9193-4277-d443-b4f4-d726bc7747de@imserv.org>
Date:   Tue, 5 Oct 2021 21:43:21 +0200
MIME-Version: 1.0
In-Reply-To: <20210505163357.16012-1-pali@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=jannis@imserv.org smtp.mailfrom=jannis@imserv.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

Just tested this patch on the SolidRun Clearfog Pro with QCA988x based 
WLE600VX wifi card. Fixes the PCI issues, works with no directly visible 
side effects on (at least) kernel 5.10.y and 5.14.y.

Tested-by: Jannis Finkler <jannis@imserv.org>


