Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 088E142A486
	for <lists+linux-pci@lfdr.de>; Tue, 12 Oct 2021 14:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236414AbhJLMgA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Oct 2021 08:36:00 -0400
Received: from office.oderland.com ([91.201.60.5]:49740 "EHLO
        office.oderland.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236386AbhJLMf6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Oct 2021 08:35:58 -0400
Received: from [193.180.18.161] (port=33228 helo=[10.137.0.14])
        by office.oderland.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <josef@oderland.se>)
        id 1maGyg-001xTd-HN; Tue, 12 Oct 2021 14:33:54 +0200
Message-ID: <ae50cd31-6b5d-3dc4-4ba7-d628a74dc722@oderland.se>
Date:   Tue, 12 Oct 2021 14:33:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:93.0) Gecko/20100101
 Thunderbird/93.0
Subject: Re: [REGRESSION][BISECTED] 5.15-rc1: Broken AHCI on NVIDIA ION
 (MCP79)
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     tglx@linutronix.de, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rui Salvaterra <rsalvaterra@gmail.com>
References: <CALjTZvbzYfBuLB+H=fj2J+9=DxjQ2Uqcy0if_PvmJ-nU-qEgkg@mail.gmail.com>
 <b023adf9-e21c-59ac-de49-57915c8cede8@oderland.se>
 <87fst6pjcu.wl-maz@kernel.org>
From:   Josef Johansson <josef@oderland.se>
In-Reply-To: <87fst6pjcu.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - office.oderland.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oderland.se
X-Get-Message-Sender-Via: office.oderland.com: authenticated_id: josjoh@oderland.se
X-Authenticated-Sender: office.oderland.com: josjoh@oderland.se
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/12/21 13:34, Marc Zyngier wrote:
> On Mon, 11 Oct 2021 19:47:21 +0100,
> Josef Johansson <josef@oderland.se> wrote:
>> I've got a late regression to this commit as well, but in the GPU area.
>> The problem arises when booting it as XEN dom0.
> What is the behaviour without Xen? We have some special treatment for
> Xen PV which may or may not have an influence on the behaviour...
>
> 	M.
>
It's working if I'm booting without Xen.

Thanks!

Regards

- Josef


