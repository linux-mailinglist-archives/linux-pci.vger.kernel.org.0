Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325A86F2522
	for <lists+linux-pci@lfdr.de>; Sat, 29 Apr 2023 16:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjD2O6V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 29 Apr 2023 10:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjD2O6V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 29 Apr 2023 10:58:21 -0400
Received: from mail-m11876.qiye.163.com (mail-m11876.qiye.163.com [115.236.118.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218AEE41;
        Sat, 29 Apr 2023 07:58:17 -0700 (PDT)
Received: from [IPV6:240e:3b7:3271:1d90:985e:a7b3:9a2c:27c7] (unknown [IPV6:240e:3b7:3271:1d90:985e:a7b3:9a2c:27c7])
        by mail-m11876.qiye.163.com (Hmail) with ESMTPA id CE5393C042D;
        Sat, 29 Apr 2023 22:58:12 +0800 (CST)
Message-ID: <13ea5739-d7d3-cefa-d8d7-540635bbdc19@sangfor.com.cn>
Date:   Sat, 29 Apr 2023 22:58:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Cc:     dinghui@sangfor.com.cn, sathyanarayanan.kuppuswamy@linux.intel.com,
        vidyas@nvidia.com, david.e.box@linux.intel.com,
        kai.heng.feng@canonical.com, michael.a.bottini@linux.intel.com,
        rajatja@google.com, qinzongquan@sangfor.com.cn,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/ASPM: fix UAF by removing cached downstream
Content-Language: en-US
To:     bhelgaas@google.com
References: <20230429132604.31853-1-dinghui@sangfor.com.cn>
From:   Ding Hui <dinghui@sangfor.com.cn>
In-Reply-To: <20230429132604.31853-1-dinghui@sangfor.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDGU8dVh1OGUxDGk9JGEsfTlUTARMWGhIXJBQOD1
        lXWRgSC1lBWUlPSx5BSBlMQUhJTEpBSh9CS0FCQ04eQRpMGUhBQhpJGEFJTBhMWVdZFhoPEhUdFF
        lBWU9LSFVKSktISkxVSktLVUtZBg++
X-HM-Tid: 0a87cd85882d2eb2kusnce5393c042d
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OSo6TCo6Mz0PDkwIIgxISzkc
        CToaFDFVSlVKTUNJTENLSUJITkNMVTMWGhIXVR8SFRwTDhI7CBoVHB0UCVUYFBZVGBVFWVdZEgtZ
        QVlJT0seQUgZTEFISUxKQUofQktBQkNOHkEaTBlIQUIaSRhBSUwYTFlXWQgBWUFKQkxJNwY+
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2023/4/29 9:26 下午, Ding Hui wrote:
> If the function 0 of a multifunction device is removed, an freed

Typo "a freed" will be fix in v2.


> downstream pointer will be left in struct pcie_link_state, and then
> when pcie_config_aspm_link() be invoked from any path, we will get a
> KASAN use-after-free report.

-- 
Thanks,
-dinghui

