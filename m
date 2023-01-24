Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF3D679322
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jan 2023 09:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbjAXIbH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Jan 2023 03:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjAXIbH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Jan 2023 03:31:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C397A2CFC4
        for <linux-pci@vger.kernel.org>; Tue, 24 Jan 2023 00:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674549022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=UXxsBzRdsQpcIJApVakqBXR1Gerwc9CsUAxMIGAHIz8=;
        b=APqi8q/BW+psLcdbt+7XX0SOdXAg8v+zhDOlJhhKKMBw3V3ipbn3bZnJtYVdpZbb3vBRz/
        hMf9JXsfYF0aGlRpmhrsxOBFWpwHYz0+c9kMYl4QKzO0hfZ2y+FqBkip+5GxCCuulGFr0B
        VKJYXL0zcafmw9kVos42hqxnMXjMb5s=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-498-m3a4V0PHPpSLRexYVFwGDw-1; Tue, 24 Jan 2023 03:30:21 -0500
X-MC-Unique: m3a4V0PHPpSLRexYVFwGDw-1
Received: by mail-ed1-f72.google.com with SMTP id y2-20020a056402440200b0049e4d71f5dcso10200359eda.5
        for <linux-pci@vger.kernel.org>; Tue, 24 Jan 2023 00:30:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UXxsBzRdsQpcIJApVakqBXR1Gerwc9CsUAxMIGAHIz8=;
        b=Vb5iivwtXCDdaoaJuKGoW++NBkKdSuxItVs4DOR3ou8Bko9Zsqwl8vPIDpko+ip4My
         cRnRxb1xAiabpuR6fPCNaeVXayIpcbFXrLgGPW45cg1kc9+S/d54xeptgio0WpuEPCJn
         7D+Me5jSg8vy06S4wfkxWGVY74Nmvoh8c7MwYLDA0TpxmNQhlC4L/u4froKUkdgNr/QQ
         yB68L7S6HOUaORNgZuxIdb1qm6HuEbVstnUp53K/xXaNyCAFlpxAxH/HlnGhNcqi7YEi
         NrlGIhMooRStmKQZ5p5QqDoM/Zc+4UaU/VAuR/My9pSTiYVlju/3aO2mO7fYGd80TowL
         ksuQ==
X-Gm-Message-State: AFqh2kom6Qm2QHXZxPevi8lUViabBRBGV1fIedXKF0a/MSPAN3Wu+Kv/
        wYdTJjQ5mSceuKBl5w7blQplaMLEhJMDRWArmgh454orwSvgkEt92rJ6mwX62H+AxUaz+EJmc9C
        yNKzBHewcYQDfOCMVuuzt+WLqh+O0COjSEFanjbkafHRlLSpFVgOM7qLSzMdfdKNB7AoyF+E=
X-Received: by 2002:a17:906:9e91:b0:84d:373b:39da with SMTP id fx17-20020a1709069e9100b0084d373b39damr25438373ejc.40.1674549019442;
        Tue, 24 Jan 2023 00:30:19 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs+Rup/JtEBRjkkQ9Wm+vFCkR2xgZK8WbsJT5LsREwe9xOOViunpxIEIwVpcY1xNiweP6wPtg==
X-Received: by 2002:a17:906:9e91:b0:84d:373b:39da with SMTP id fx17-20020a1709069e9100b0084d373b39damr25438357ejc.40.1674549019065;
        Tue, 24 Jan 2023 00:30:19 -0800 (PST)
Received: from [192.168.1.121] (91-145-109-188.bb.dnainternet.fi. [91.145.109.188])
        by smtp.gmail.com with ESMTPSA id kv15-20020a17090778cf00b00877df3eea64sm564132ejc.155.2023.01.24.00.30.18
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 00:30:18 -0800 (PST)
Message-ID: <fed46c6e-1617-6dbb-9478-8137eecb5855@redhat.com>
Date:   Tue, 24 Jan 2023 10:30:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From:   =?UTF-8?Q?Mika_Penttil=c3=a4?= <mpenttil@redhat.com>
Subject: PCIe errors after resume from hibernate
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Hi,


While debugging failure (in recent mainline linux kernels) to restore 
screen contents after hibernate (S4), there seem to be bad looking PCIe 
errors in the logs. GPU is not responding, and network card is not 
working. Everything is locked up.

Anyone seen similar or any ideas?

--Mika



[   79.321993] pcieport 0000:6f:02.0: AER: aer_status: 0x00001000, 
aer_mask: 0x00000000
[   79.321997] pcieport 0000:6f:02.0:    [12] Timeout
[   79.321999] pcieport 0000:6f:02.0: AER: aer_layer=Data Link Layer, 
aer_agent=Transmitter ID
[   79.322014] nvme 0000:70:00.0: AER: aer_status: 0x00000001, aer_mask: 
0x00000000
[   79.322016] nvme 0000:70:00.0:    [ 0] RxErr                  (First)
[   79.322017] nvme 0000:70:00.0: AER: aer_layer=Physical Layer, 
aer_agent=Receiver ID
[   84.371185] {9}[Hardware Error]: Hardware error from APEI Generic 
Hardware Error Source: 0
[   84.371188] {9}[Hardware Error]: It has been corrected by h/w and 
requires no further action
[   84.371190] {9}[Hardware Error]: event severity: corrected
[   84.371191] {9}[Hardware Error]:  Error 0, type: corrected
[   84.371192] {9}[Hardware Error]:   section_type: PCIe error
[   84.371193] {9}[Hardware Error]:   port_type: 0, PCIe end point
[   84.371193] {9}[Hardware Error]:   version: 3.0
[   84.371194] {9}[Hardware Error]:   command: 0x0547, status: 0x0010
[   84.371195] {9}[Hardware Error]:   device_id: 0000:70:00.0
[   84.371196] {9}[Hardware Error]:   slot: 0
[   84.371196] {9}[Hardware Error]:   secondary_bus: 0x00
[   84.371197] {9}[Hardware Error]:   vendor_id: 0x15b7, device_id: 0x5011
[   84.371198] {9}[Hardware Error]:   class_code: 020801
[   84.371223] nvme 0000:70:00.0: AER: aer_status: 0x00000001, aer_mask: 
0x00000000
[   84.371227] nvme 0000:70:00.0:    [ 0] RxErr                  (First)
[   84.371229] nvme 0000:70:00.0: AER: aer_layer=Physical Layer, 
aer_agent=Receiver ID
[   84.382169] nvme 0000:70:00.0: AER: aer_status: 0x00000001, aer_mask: 
0x00000000
[   84.382173] nvme 0000:70:00.0:    [ 0] RxErr                  (First)
[   84.382176] nvme 0000:70:00.0: AER: aer_layer=Physical Layer, 
aer_agent=Receiver ID
[   85.650235] nvme 0000:70:00.0: AER: aer_status: 0x00000001, aer_mask: 
0x00000000
[   85.650241] nvme 0000:70:00.0:    [ 0] RxErr                  (First)
[   85.650243] nvme 0000:70:00.0: AER: aer_layer=Physical Layer, 
aer_agent=Receiver ID
[   85.804828] No UUID available providing old NGUID
[   86.367475] nvme 0000:70:00.0: AER: aer_status: 0x00000001, aer_mask: 
0x00000000
[   86.367482] nvme 0000:70:00.0:    [ 0] RxErr                  (First)
[   86.367483] nvme 0000:70:00.0: AER: aer_layer=Physical Layer, 
aer_agent=Receiver ID
[   86.851162] nvme 0000:70:00.0: AER: aer_status: 0x00000001, aer_mask: 
0x00000000
[   86.851171] nvme 0000:70:00.0:    [ 0] RxErr                  (First)
[   86.851174] nvme 0000:70:00.0: AER: aer_layer=Physical Layer, 
aer_agent=Receiver ID
[   87.154895] nvme 0000:70:00.0: AER: aer_status: 0x00000001, aer_mask: 
0x00000000
[   87.154901] nvme 0000:70:00.0:    [ 0] RxErr                  (First)
[   87.154903] nvme 0000:70:00.0: AER: aer_layer=Physical Layer, 
aer_agent=Receiver ID
[   87.481288] nvme 0000:70:00.0: AER: aer_status: 0x00000001, aer_mask: 
0x00000000
[   87.481294] nvme 0000:70:00.0:    [ 0] RxErr                  (First)
[   87.481296] nvme 0000:70:00.0: AER: aer_layer=Physical Layer, 
aer_agent=Receiver ID
[   88.318209] nvme 0000:70:00.0: AER: aer_status: 0x00000001, aer_mask: 
0x00000000
[   88.318216] nvme 0000:70:00.0:    [ 0] RxErr                  (First)
[   88.318218] nvme 0000:70:00.0: AER: aer_layer=Physical Layer, 
aer_agent=Receiver ID
[   88.578533] nvme 0000:70:00.0: AER: aer_status: 0x00000001, aer_mask: 
0x00000000
[   88.578540] nvme 0000:70:00.0:    [ 0] RxErr                  (First)
[   88.578544] nvme 0000:70:00.0: AER: aer_layer=Physical Layer, 
aer_agent=Receiver ID

